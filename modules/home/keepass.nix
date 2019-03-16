{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.keepass;
  isEnabled = profile: config.blox.profiles.${profile}.enable;
in {
  options.blox.profiles.keepass.enable = mkEnableOption "KeePass with plugins";

  config = mkIf cfg.enable {
    home.packages = (with pkgs.bloxpkgs.unstable; [
      (pkgs.keepass.override {
        plugins = [
          keepass-keeagent
          pkgs.bloxpkgs.keepass-keechallenge
        ] ++ optionals (isEnabled "workstation") [
          keepass-keepassrpc
        ];
      })
    ]);

    home.file = mkIf (isEnabled "zsh") {
    ".config/zsh/conf.d/10-keeagent-env.rc".text = ''
      export SSH_AUTH_SOCK=''${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/keeagent.socket}
    '';
    };
  };
}
