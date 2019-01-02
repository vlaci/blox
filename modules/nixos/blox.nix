{ config, lib, pkgs, ...}: with lib;

let
  cfg = config.blox.blox;
in {
  options.blox.blox.installDocs = mkOption {
    description = "Whether to install documentation for `blox`";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg.installDocs {
    environment.systemPackages = let
      doc = import ../../doc { inherit pkgs; };
      manpages = pkgs.runCommand "blox-manpages"
        { }
        ''
          mkdir -p $out/share/man/man5
          cp ${doc.man} $out/share/man/man5/blox-configuration.5
        ''
      ;
    in [ manpages ];
  };
}
