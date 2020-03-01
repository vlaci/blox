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

  config = mkIf cfg.enable (mkMerge [
    {
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
        scrot
        vlc
        xclip
        xsel

        arc-theme
        material-design-icons
        paper-icon-theme
        redshift
      ]) ++ (with pkgs.bloxpkgs; [
        mozilla.latest.firefox-bin
      ]) ++ optionals cfg.light-locker.enable [ pkgs.lightlocker ];
      home.file = {
        ".config/kitty/kitty.conf".source = ./kitty.conf;
        ".config/rofi/config.rasi".source = ./config.rasi;
      };

      home.keyboard.layout = mkDefault nixosConfig.blox.i18n.xlayout;
    }
    (mkIf nixosConfig.programs.browserpass.enable {
      # https://github.com/NixOS/nixpkgs/issues/47340
      home.file.".mozilla/native-messaging-hosts/com.github.browserpass.native.json".source = "${pkgs.browserpass}/lib/browserpass/hosts/firefox/com.github.browserpass.native.json";
    })
  ]);
}
