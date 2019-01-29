{ lib
, jq
, runCommand
, emacs
, emacsPackages
, emacsPackagesNgGen
, emacs_d
, loadPath ? []
, extraPackages ? self: [ ]
, overrides ? self: super: { } }:

let
  inherit (builtins) readFile fromJSON hasAttr getAttr;
  inherit (lib) concatMapStrings;

  emacsPackages =
    let
      epkgs = emacsPackagesNgGen emacs;
    in
      epkgs.overrideScope' overrides;

  packagesNeeded =
    let
      packageNames = fromJSON
                         (readFile package-list);
      package-list =
        runCommand "package-list" {
          buildInputs = [ emacsPackages.emacs ];
        }
        ''
          EMACS_D=${emacs_d}
          emacs --batch --quick \
                -L ${emacsPackages.use-package
                    }/share/emacs/site-lisp/elpa/use-package-* \
                -L ${emacsPackages.delight
                    }/share/emacs/site-lisp/elpa/delight-* \
                -L ${emacsPackages.bind-key
                    }/share/emacs/site-lisp/elpa/bind-key-* \
                -L $EMACS_D \
                ${concatMapStrings (p: "-L ${p}/share/emacs/site-lisp ") loadPath} \
                -l ${./elisp/use-package-list.el} \
            --eval "(use-package-list \"$EMACS_D/init.el\")" \
                > $out
          echo
          echo Packages to be installed:
          cat $out | ${jq}/bin/jq -r 'sort | join(" ")'
          echo
        '';
    in
      epkgs: map (x:
        if hasAttr x epkgs
          then getAttr x epkgs
        else abort "no attribute found for use-package ${x}") packageNames;

in
emacsPackages.emacsWithPackages (epkgs:
  (packagesNeeded epkgs)
  ++ (extraPackages epkgs)
  ++  [epkgs.use-package]
)
