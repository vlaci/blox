{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.emacs;
in {
  options.blox.profiles.emacs = {
    enable = mkEnableOption "custom Emacs config";

    features = {
      helm.enable = mkEnableOption "helm";
      boon.enable = mkEnableOption "boon";
      xah-fly-keys.enable = mkEnableOption "xah-fly-keys";
      evil.enable = mkEnableOption "evil";
      flyspell.enable = mkEnableOption "flyspell";
      flyspell.dictionaries = mkOption {
        description = "";
        type = with types; listOf package;
        default = [ pkgs.hunspellDicts.en-us ];
      };
      mu4e.enable = mkEnableOption "mu4e";
    };
  };

  imports = [
    ./wrapped.nix
  ];

  config = let
    dictionaries = concatMapStringsSep "," (dct: dct.dictFileName) cfg.features.flyspell.dictionaries;
    hunspell = pkgs.hunspellWithDicts cfg.features.flyspell.dictionaries;
    profiles = config.blox.profiles.development;
  in mkIf cfg.enable {
    blox.profiles.emacs.features.flyspell.dictionaries = [ pkgs.hunspellDicts.en-us pkgs.bloxpkgs.unstable.hunspellDicts.hu-hu ];
    blox.packages.emacs = {
      enable = true;
      dotEmacsDir = ./emacs.d;
      features = rec {
        helm.enable = true;
        helm.extraVars."helm-ag-base-command" = ''"${pkgs.ag}/bin/ag --nocolor --nogroup"'';
        xah-fly-keys.enable = false;
        boon.enable = false;
        evil.enable = true;
        flyspell.enable = true;
        flyspell.extraVars."ispell-program-name" = ''"${hunspell}/bin/hunspell"'';
        flyspell.extraVars."ispell-dictionary" = ''"${dictionaries}"'';

        lsp.enable = true;
        org.enable = true;
        c = {
          enable = profiles.c.enable;
          extraVars."blox-c-lsp-executable" = ''
            "${profiles.c.ccls}/bin/ccls"'';
        };
        lua = {
          enable = profiles.lua.enable;
        };
        python = {
          enable = profiles.python.enable;
          extraVars."blox-python-lsp-command" = ''
            '("pyls")
          '';
        };
        php = {
          enable = profiles.php.enable;
          extraVars."blox-php-lsp-command" = ''
            '("${pkgs.php}/bin/php" "${profiles.php.php-language-server}/bin/php-language-server.php")
          '';
        };

        rust = {
          enable = profiles.rust.enable;
          extraVars."blox-rust-lsp-command" = ''
            '("${profiles.rust.rls}/bin/rls")
          '';
        };
        mu4e =
        let
          mu = pkgs.mu;
        in {
          extraVars."blox-mu4e-path" = ''
            "${mu}/share/emacs/site-lisp/mu4e"
          '';
          extraVars."blox-mu-binary" = ''
            "${mu}/bin/mu"
          '';
          extraVars."blox-mu-msg2pdf-binary" = ''
            "${mu}/bin/msg2pdf"
          '';
          extraVars."blox-gpg-binary" = ''
            "${pkgs.gnupg}/bin/gpg"
          '';
        };
      };

      overrides = self: super: { };
    };
    nixpkgs.config.permittedInsecurePackages = [
      "webkitgtk-2.4.11"
    ];
  };
}
