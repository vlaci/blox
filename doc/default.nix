{ pkgs ? import <nixpkgs> { } }:
with pkgs.lib;

let
  systemOpts = (import <nixpkgs/nixos> {
    configuration = {
    imports = [
      ../modules/nixos
    ];
    _module.check = false;
    nixpkgs.config.allowBroken = true;
  };
  }).options;

  homeOpts = (import <nixpkgs/nixos> {
    configuration = {
    imports = [
      ../modules/home
    ];
    _module.args = {
      nixosConfig = {};
    };
    _module.check = false;
  };
  }).options;

  normalize = options:
    let
     moduleRoot = toString ../.;
     visible = filter (opt:
        opt.visible &&
        !opt.internal &&
        all (hasPrefix moduleRoot) opt.declarations
      )
      (optionAttrSetToDocList options);
    in
      flip map visible (opt: opt // {
        declarations = map (d: removePrefix moduleRoot d) opt.declarations;
       });
in rec {
  definitions = pkgs.writeText "definitions.json" (builtins.toJSON (
    (map (o: o // { valid_in = "nixos";}) (normalize systemOpts))
    ++ (map (o: o // { valid_in = "home-manager";}) (normalize homeOpts))
  ));

  markdown = pkgs.runCommand "options.md" {
    buildInputs = with pkgs; [ python3 glibcLocales ];
  } ''
    export LC_ALL=en_US.UTF-8
    python3 ${./generate.py} ${definitions} > $out
  '';

  man = pkgs.runCommand "options.5" {
    buildInputs = with pkgs; [ (python3.withPackages (ps: [ps.pandocfilters])) pandoc ];
    inherit markdown;
  } ''
    pandoc \
        --from=markdown \
        --to=man \
        --standalone \
        --filter ${./format_man.py} \
        ${./metadata.yaml} \
        $markdown \
    > $out
  '';
}
