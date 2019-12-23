{ lib, config, nixosConfig, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.workstation;
in {
  options.blox.profiles.workstation.enable = mkEnableOption "";
  options.blox.profiles.workstation.light-locker.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to use light-locker for screen locking";
  };

  imports = [
    ./awesome
    ./compositor
  ];

  config = mkIf cfg.enable {
    home.packages = (with pkgs; [
      bloxpkgs.dropbox-with-fs-fix
      evince
      flameshot
      gimp
      kitty
      libreoffice-fresh
      networkmanager_dmenu
      pavucontrol
      pcmanfm
      rofi
      remmina
      vlc
      xclip
      xsel

      arc-theme
      paper-icon-theme
    ]) ++ (with pkgs.bloxpkgs; [
      mozilla.latest.firefox-bin
      material-design-icons
    ]) ++ optionals cfg.light-locker.enable [ pkgs.lightlocker ];
    home.file = {
      ".config/kitty/kitty.conf".source = ./kitty.conf;
      ".config/rofi/config.rasi".source = ./config.rasi;
    };

    home.keyboard.layout = mkDefault nixosConfig.blox.i18n.xlayout;
  };
}
