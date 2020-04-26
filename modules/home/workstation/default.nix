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

        paper-gtk-theme
        material-design-icons
        paper-icon-theme
        redshift
        firefox-bin
      ]) ++ (with pkgs.bloxpkgs; [
      ]) ++ optionals cfg.light-locker.enable [ pkgs.lightlocker ];
      home.file = {
        ".config/rofi/config.rasi".source = ./config.rasi;
      };

      home.keyboard.layout = mkDefault nixosConfig.blox.i18n.xlayout;
      programs.kitty = {
        enable = true;
        keybindings = {
          "ctrl+c" = "copy_or_interrupt";
          "shift+page_up" = "scroll_page_up";
          "shift+page_down" = "scroll_page_down";
        };
        settings = {
          font_size = 10;

          # Nord theme - ported from https://github.com/arcticicestudio/nord-hyper
          foreground = "#D8DEE9";
          background = "#2E3440";
          selection_foreground = "#000000";
          selection_background = "#FFFACD";
          url_color = "#0087BD";
          cursor = "#81A1C1";

          # black
          color0 = "#3B4252";
          color8 = "#4C566A";

          # red
          color1 = "#BF616A";
          color9 = "#BF616A";

          # green
          color2 = "#A3BE8C";
          color10 = "#A3BE8C";

          # yellow
          color3 = "#EBCB8B";
          color11 = "#EBCB8B";

          # blue
          color4 = "#81A1C1";
          color12 = "#81A1C1";

          # magenta
          color5 = "#B48EAD";
          color13 = "#B48EAD";

          # cyan
          color6 = "#88C0D0";
          color14 = "#8FBCBB";

          # white
          color7 = "#E5E9F0";
          color15 = "#B48EAD";

          select_by_word_characters = "@-./_~?&=%+#";
        };
      };
    }
    (mkIf nixosConfig.programs.browserpass.enable {
      # https://github.com/NixOS/nixpkgs/issues/47340
      home.file.".mozilla/native-messaging-hosts/com.github.browserpass.native.json".source = "${pkgs.browserpass}/lib/browserpass/hosts/firefox/com.github.browserpass.native.json";
    })
  ]);
}
