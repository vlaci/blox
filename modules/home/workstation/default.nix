{ lib, config, nixosConfig, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.workstation;
in {
  options.blox.profiles.workstation.enable = mkEnableOption "";

  imports = [
    ./awesome
    ./compositor
  ];

  config = mkIf cfg.enable {
    home.packages = (with pkgs; [
      bloxpkgs.dropbox-with-fs-fix
      evince
      gimp
      kitty
      libreoffice-fresh
      networkmanager_dmenu
      pavucontrol
      pcmanfm
      rofi
      remmina
      scrot
      vlc
      xclip
      xsel

      arc-theme
      paper-icon-theme
    ]) ++ (with pkgs.bloxpkgs; [
      mozilla.latest.firefox-bin
       material-design-icons
    ]);
    home.file = {
      ".config/kitty/kitty.conf".source = ./kitty.conf;
      ".config/rofi/config.rasi".source = ./config.rasi;
    };

    home.keyboard.layout = mkDefault nixosConfig.blox.i18n.xlayout;
  };
}
