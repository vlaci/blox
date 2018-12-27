{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.features.keepass;
  isEnabled = feature: config.blox.features.${feature}.enable;
in {
  options.blox.features.keepass.enable = mkEnableOption "KeePass with plugins";

  config = mkIf cfg.enable {
    home.packages = (with pkgs.bloxpkgs.unstable; [
      (keepass.override {
        plugins = [
          keepass-keeagent
        ] ++ optionals (isEnabled "workstation") [
          keepass-keepassrpc
        ];
      })
    ]) ++ optionals (isEnabled "workstation") (with pkgs; [
      xdotool
    ]);

    home.file = mkIf (isEnabled "zsh") {
    ".config/zsh/conf.d/10-keeagent-env.rc".text = ''
      export SSH_AUTH_SOCK=''${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/keeagent.socket}
    '';
    };
  };
}
