{ lib, config, nixosConfig, pkgs, bloxpkgs, ... }: with lib;

let
  cfg = config.blox.features.workstation;
in {
  options.blox.features.workstation.enable = mkEnableOption "";

  imports = [
    ./awesome
    ./compositor
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; with bloxpkgs; [
      evince
      mozilla.latest.firefox-bin
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
      material-design-icons
      paper-icon-theme
    ];
    home.file = {
      ".config/kitty/kitty.conf".source = ./kitty.conf;
      ".config/rofi/config.rasi".source = ./config.rasi;
    };

    home.keyboard.layout = mkDefault nixosConfig.blox.i18n.xlayout;
  };
}
