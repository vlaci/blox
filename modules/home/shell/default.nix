{ config, lib, pkgs, system, ... }: with lib;

let
  cfg = config.blox.profiles.zsh;
  dotDir = ".config/zsh";
  mkHint = id: id;
in {
  options.blox.profiles.zsh.enable = mkEnableOption "zsh";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = mkHint true;
      enableCompletion = mkHint false;
      inherit dotDir;
      history = {
        expireDuplicatesFirst = mkHint true;
        extended = true;
      };
      initExtra = ''
        # Do not remember commands that start with a whitespace
        setopt HIST_IGNORE_SPACE
        # Correct spelling of all arguments in the command line
        setopt CORRECT_ALL


        source $ZDOTDIR/grml-zshrc
        source $ZDOTDIR/zshrc.local
      '';
      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "v1.54";
            sha256 = "019hda2pj8lf7px4h1z07b9l6icxx4b2a072jw36lz9bh6jahp32";
          };
        }
      ];
    };
    home.file = {
      "${dotDir}/grml-zshrc".source = "${pkgs.grml-zsh-config}/etc/zsh/zshrc";
      "${dotDir}/zshrc.local".source = ./zshrc.local;
      ".config/zsh/conf.d/try.rc".source = pkgs.substituteAll {
        src = ./command_not_found.zsh;
        inherit system;
        inherit (pkgs) sqlite;
      };
    };
    home.packages = with pkgs; [
      bashInteractive  # to ensure bash with readline sujpport even if it isn't the default shell
    ];

    programs.starship.enable = true;
    programs.fzf.enable = true;
    services.lorri.enable = true;
  };
}
