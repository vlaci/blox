{ config, lib, pkgs, inputs, ... }: with lib;

let
  cfg = config.blox.profiles.doom-emacs;
in {
  options.blox.profiles.doom-emacs = {
    enable = mkEnableOption "Doom Emacs configuration";
    doomPrivateDir = mkOption {
      description = ''
        Directory containing customizations, `init.el`, `config.el` and `packages.el`
      '';
      default = ./doom.d;
    };
    extraConfig = mkOption {
      description = "Extra configuration options to pass to doom-emacs";
      type = with types; lines;
      default = "";
    };
    extraPackages = mkOption {
      description = "Extra packages to install";
      type = with types; listOf package;
      default = [];
    };
    package = mkOption {
      internal = true;
    };
  };

  config = mkIf cfg.enable (let
    emacs = pkgs.callPackage inputs.nix-doom-emacs {
      extraPackages = (epkgs: cfg.extraPackages);
      inherit (cfg) extraConfig doomPrivateDir;
    };
  in {
    home.file.".emacs.d/init.el".text = ''
      (setq phpactor-install-directory "${pkgs.bloxpkgs.phpPackages.phpactor}/share/php/composer-phpactor/")
      (load "default.el")
    '';
    home.packages = with pkgs; [
      python3Packages.grip
      mdl
    ];
    programs.emacs.package = emacs;
    programs.emacs.enable = true;
    blox.profiles.doom-emacs.package = emacs;
  });
}
