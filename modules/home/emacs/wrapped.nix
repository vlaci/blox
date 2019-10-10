{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.packages.emacs;

  buildArgs = { emacs = pkgs.emacs; emacs_d = ./emacs.d; overrides = cfg.overrides; loadPath = [ nixIntegration ];};

  # First we generate an emacs environment capable of compiling the init files themselves
  stage1 = pkgs.callPackage ./emacsUsePackage.nix buildArgs;

  # Second we add the compiled init files to the closure
  stage2 = pkgs.callPackage ./emacsUsePackage.nix (buildArgs // { extraPackages = const [ nixIntegration initFiles ]; });

  nixIntegration = let
    features = mapAttrsToList
      (n: v:
        "(defvar blox-${n}-enable ${if v.enable then "t" else "nil"})"
      ) cfg.features;
    extraVars =
      (concatMap
        (v:
          (if v.enable then (mapAttrsToList (n: v: "(setq-default ${n} ${v})")) v.extraVars else [ ])
        ) (attrValues cfg.features));
    extraConfig = (map (v: if v.enable then v.extraConfig else "")) (attrValues cfg.features);
  in pkgs.runCommand "nix-integration" {
    nixIntegration = ''
      ;;; -*- lexical-binding: t; -*-

      ${concatStringsSep "\n" features}

      ${concatStringsSep "\n" extraVars}

      ${concatStringsSep "\n" extraConfig}
    '';
    passAsFile = [ "nixIntegration" ];
  }
  ''
    mkdir -p $out/share/emacs/site-lisp
    cp $nixIntegrationPath  $out/share/emacs/site-lisp/nix-integration.el
  '';

  initFiles = pkgs.runCommand "emacs.d" {
    buildInputs = [ stage1 ];
  }
  ''
    mkdir -p $out/share/emacs/site-lisp
    cp -r ${cfg.dotEmacsDir}/* $out/share/emacs/site-lisp

    cd $out/share/emacs/site-lisp
    mv init.el default.el
    export HOME=$PWD
    log=$(mktemp)
    chmod -R u+w $(find -type d)
    #emacs -Q -nw -L . -L ${nixIntegration}/share/emacs/site-lisp --batch -f batch-byte-compile $(find -name \*.el | sort)
  '';

  emacsFeature = { name, config, ... }: {
    options = {
      enable = mkEnableOption name;
      extraVars = mkOption {
        description = ''
          Extra variables needed for the given feature.
          Useful to integrate with external tools. The variables
          are generated to `nix-integration.el`.
        '';
        example = literalExample ''
          helm.tools."helm-ag-base-command" = '''"''${pkgs.ag}/bin/ag --nocolor --nogroup"''';
        '';
        type = with types; loaOf str;
        default = { };
      };
      extraConfig = mkOption {
        description = "Additional elisp configuration";
        type = with types; str;
        default = "";
      };
    };
  };
in {
  options.blox.packages.emacs = {
    enable = mkEnableOption "custom Emacs config";

    dotEmacsDir = mkOption {
      description = "Contents of the user's `.emacs.d` directory.";
      type = types.path;
    };

    features = mkOption {
      description = ''
        Enable or disable certain emacs features exposed by the user
        configuration.

        The feature descriptions are presented in `nix-integration.el`
        available on the load path. To load them add the following to
        your init file:
        ```
        (load "nix-integration")
        ```
      '';
      type = with types; loaOf (submodule emacsFeature);
    };

    overrides = mkOption {
      default = self: super: {};
      defaultText = "self: super: {}";
      example = literalExample ''
        self: super: rec {
          haskell-mode = self.melpaPackages.haskell-mode;
          # ...
        };
      '';
      description = ''
        Allows overriding packages within the Emacs package set.
      '';
    };

    finalPackage = mkOption {
      description = "emacs package and all its dependencies";
      type = types.package;
      internal = true;
    };
  };

  config = mkIf cfg.enable {
    blox.packages.emacs.finalPackage = stage2;

    home.packages = [
      cfg.finalPackage
    ];

    home.file.".emacs.d/init.el".text = ''
    ;;; This init file is only needed to bypass the standard welcome screen.
    ;;; All other configuration is loaded from site-lisp instead
    (load "default")
    '';
  };
}
