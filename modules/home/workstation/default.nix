{ lib, config, nixosConfig, pkgs, ... }: with lib;

let
  cfg = config.blox.features.workstation;
in {
  options.blox.features.workstation.enable = mkEnableOption "";

  imports = [
    ./awesome
    ./compositor
  ];

  config = mkIf cfg.enable {
    home.packages = (with pkgs; [
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
