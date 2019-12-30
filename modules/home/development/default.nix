{ config, options, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.development;
  mkEnableOption' = name: default: mkOption {
    description = "Whether to enable ${name}.";
    type = types.bool;
    defaultText = "blox.profiles.development.enable";
    inherit default;
  };
in {
  options.blox.profiles.development = mkOption {
    description = ''
      Development tools related options.
    '';
    default = {};
    example = ''
      # enable all subgroups:
      { enable = true; }

      # enable specific groups:
      {
        c.enable = true;
        python.enable = true;
      }

      # enable everything but Python:
      {
        enable = true;
        python.enable = false;
      }
    '';
    type = types.submodule ({ config, ... }: {
      options = with pkgs; {
        enable = mkEnableOption "all development tools";
        c = {
          enable = mkEnableOption' "C/C++ tooling" config.enable;
          ccls = mkOption {
            type = types.package;
            description = "clangd package to use";
            default = bloxpkgs.unstable.ccls;
            defaultText = "llvmPackages.clang-unwrapped";
          };
        };
        php = {
          enable = mkEnableOption' "PHP tooling" config.enable;
          php-language-server = mkOption {
            type = types.package;
            description = "php-language-server package to use";
            default = bloxpkgs.phpPackages.php-language-server;
            defaultText = "bloxpkgs.phpPackages.php-language-server";
          };
        };
        python = {
          enable = mkEnableOption' "Python (2 and 3) tooling" config.enable;
          pyls = mkOption {
            description = "pyls environment for Python 3";
            default = (ps: with ps; [
              flake8
              pylama
              pylint
              importmagic
              python-language-server
              pyls-black
              pyls-isort
              pyls-mypy
            ]);
            defaultText = ''
              python.withPackages (ps: with ps; [
                flake8
                pylama
                pylint
                importmagic
                python-language-server
                pyls-black
                pyls-isort
                pyls-mypy
              ])
            '';
          };
        };
        rust = {
          enable = mkEnableOption' "Rust tooling" config.enable;
          rls = mkOption {
            type = types.package;
            description = "rls package to use";
            default = bloxpkgs.unstable.rls;
            defaultText = "rls";
          };
        };
        tools.enable = mkEnableOption' "miscellaneous tools" config.enable;
      };
    });
  };

  config = with pkgs; {
    home.packages = optionals cfg.c.enable [
      cfg.c.ccls
      gcc
      lldb
    ] ++ optionals cfg.python.enable [
      pipenv
      bloxpkgs.unstable.python3.pkgs.poetry
      (python3Full.withPackages (ps: with ps; [
        jupyterlab
        setuptools
      ] ++ (cfg.python.pyls ps)))
      (pythonFull.withPackages (ps: with ps; [ setuptools ]))
    ] ++ optionals cfg.php.enable [
      php
      phpPackages.composer
    ] ++ optionals cfg.rust.enable [
      rustup
    ]  ++ optionals cfg.tools.enable (
      [
        jq
        ripgrep
      ] ++ optionals config.blox.profiles.workstation.enable [
        diffuse
        meld
        bloxpkgs.unstable.vscode
      ] ++ optionals config.blox.profiles.zsh.enable [
        direnv
      ]
    );

    home.file = (optionalAttrs cfg.tools.enable {
        ".config/zsh/conf.d/10-direnv.rc".text = ''
          eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
        '';
      } // optionalAttrs config.blox.profiles.workstation.enable {
        ".config/zsh/conf.d/10-vscode-env.rc".text = ''
          if [[ ''${TERM_PROGRAM-} == vscode ]]; then
              export EDITOR="code -r --wait"
          fi
        '';
      });

    programs.neovim = let
      extraConfig = ''
        let g:LanguageClient_serverCommands = {
        \${optionalString cfg.c.enable " 'c': ['ccls'],"}
        \${optionalString cfg.php.enable " 'php' : ['${php}/bin/php', '${cfg.php.php-language-server}/bin/php-language-server.php'],"}
        \${optionalString cfg.python.enable " 'python': ['pyls'],"}
        \${optionalString cfg.rust.enable " 'rust': ['${cfg.rust.rls}/bin/rls'],"}
        \}
      '' + (builtins.readFile ./init.vim);
      plugins =
        (with pkgs.bloxpkgs.vimPlugins; [
          tender
          yarp
          ncm2
          emmet
          which-key
        ]) ++ (with pkgs.bloxpkgs.unstable.vimPlugins; [
          LanguageClient-neovim
        ]) ++ (with pkgs.vimPlugins; [
          neomake
          vim-nix
          vim-airline
          vim-airline-themes
          vim-toml
          fzf-vim fzfWrapper
          surround
          fugitive
        ]);
      in (mkIf (cfg.enable || cfg.tools.enable) ({
        enable = mkDefault true;
      } // (
        if hasAttr "extraConfig" options.programs.neovim then
          # COMPAT: home-manager >= 19.09
          { inherit extraConfig plugins; }
        else
          # COMPAT: home-manager < 19.09
          { configure = {
              customRC = extraConfig;
              packages.myVimPackage.start = plugins;
            };
          }
      )));

    programs.git = {
      aliases = {
        lol = "log --graph --pretty=format:\\\"%C(yellow)%h%Creset%C(cyan)%C(bold)%d%Creset %C(cyan)(%cr)%Creset %C(green)%ae%Creset %s\\\"";
      };
      extraConfig = {
        push.default = "upstream";
        "protocol.keybase".allow = "always";
        diff.tool = "kitty";
        diff.guitool = "kitty.gui";
        difftool.prompt = "false";
        difftool.trustExitCode = "true";
        "difftool \"kitty\"".cmd = "kitty +kitten diff $LOCAL $REMOTE";
        "difftool \"kitty.gui\"".cmd = "kitty kitty +kitten diff $LOCAL $REMOTE";
      };
      ignores = [
      ];
    };
  };
}
