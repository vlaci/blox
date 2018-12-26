{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.features.zsh;
in {
  options.blox.features.zsh.enable = mkEnableOption "zsh";

  config.home.file = mkIf cfg.enable {
    ".zshrc".source = "/etc/zshrc.local";
    ".zshrc.pre".source = ./zshrc.pre;
    ".zshrc.local".source = ./zshrc.local;
    ".config/zsh/conf.d/10-antigen.pre".text = ''
      source ${pkgs.antigen}/share/antigen/antigen.zsh
      export _ANTIGEN_WARN_DUPLICATES=0
      antigen bundle zsh-users/zsh-syntax-highlighting
      antigen bundle chisui/zsh-nix-shell.git
      antigen bundle git
      antigen apply
    '';
    ".config/zsh/conf.d/11-aliases.rc".text = ''
      alias nix-env="noglob nix-env"
      alias find="noglob find"
    '';
  };
}
