{ config, lib, pkgs, ... }: with lib;

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
    spellCheckDictionaries = mkOption {
      description = "Use these dictionaries for spell-checking";
      type = with types; listOf package;
      default = [];
    };
    package = mkOption {
      internal = true;
    };
  };

  config = mkIf cfg.enable (let
    extraConfig = let
      hunspell = pkgs.hunspellWithDicts cfg.spellCheckDictionaries;
      languages = lib.concatMapStringsSep "," (dct: dct.dictFileName) cfg.spellCheckDictionaries;
    in ''
      (setq ispell-program-name "${hunspell}/bin/hunspell"
            ispell-dictionary "${languages}")
      (after! ispell
        (ispell-set-spellchecker-params)
        (ispell-hunspell-add-multi-dic ispell-dictionary))
      ${cfg.extraConfig}
    '';
    emacs = pkgs.callPackage (builtins.fetchTarball {
      url = https://github.com/vlaci/nix-doom-emacs/archive/develop.tar.gz;
    }) {
      extraPackages = (epkgs: cfg.extraPackages);
      inherit (cfg) doomPrivateDir; inherit extraConfig;
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
