{ pkgs ? import <nixpkgs> { } }:
with pkgs.lib;

let
  moduleArgs = {
    imports = [{
      _module.args = {
        inherit pkgs;
        nixosConfig = { };
      };
      _module.check = false;
      nixpkgs.config.allowBroken = true;
    }];
  };

  systemOpts = (evalModules {
    specialArgs.inputs.home-manager.nixosModules.home-manager = { };
    modules = [
      {
        imports = [
          ../modules/nixos
        ];
      }
      moduleArgs
    ];
  }).options;

  homeOpts = (evalModules {
    modules = [
      {
        imports = [
          ../modules/home
        ];
      }
      moduleArgs
    ];
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
