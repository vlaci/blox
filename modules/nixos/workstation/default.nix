
{ config, options, lib, pkgs, ... }: with lib;

let
  feat = config.blox.profiles;
  bloxpkgs = import ../../../pkgs { inherit pkgs; };
in {
  imports = [
    ./cursor.nix
  ];

  options.blox.profiles.workstation.enable = mkEnableOption "";
  config = mkIf feat.workstation.enable {
    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    environment.systemPackages = with pkgs; [
      gvfs  # automounting and mtp
    ];

    fonts = {
      fonts = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        ia-writer-duospace
        unifont
        siji
        fira-code
        fira-code-symbols
        fira-mono
        emacs-all-the-icons-fonts
      ];
      fontconfig = {
        localConf = builtins.readFile ./fonts.conf;
        defaultFonts = {
          monospace = [ "Fira Mono" ];
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
        };
      };
    };

    services.xserver = {
      enable = true;
      libinput = {
        enable = true;
        naturalScrolling = true;
      };

      desktopManager.xterm.enable = false;
      desktopManager.session = [{
        name = "home-manager";
        start = ''
        ${pkgs.stdenv.shell} $HOME/.xsession-hm &
        waitPID=$!
        '';
      }];

      displayManager.lightdm =
      {
        enable = true;
        greeters.gtk  = {
          theme = {
            package = pkgs.materia-theme;
            name = "Materia";
          };
          cursor = {
            package = bloxpkgs.pixelfun;
            name = "pixelfun3";
          };
          extraConfig = ''
            hide-user-image = true
          '';
          indicators = [
            "~host" "~spacer"
            "~clock" "~spacer"
            "~session"
            "~language"
            "~a11y"
            "~power"
          ];
        };
      };
    };

    # to allow virt-manager and stuff write their settings
    services.dbus.packages = with pkgs; [ gnome3.dconf ];

    services.gnome3.gnome-keyring.enable = true;

    environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];
    environment.variables.SOUND_THEME_FREEDESKTOP = "${pkgs.sound-theme-freedesktop}";
  } // (
    if (hasAttr "programs" options) then
      # COMPAT: NixOS >= 19.09
      { programs.seahorse.enable = true; }
    else
      # COMPAT: NixOS < 19.09
      { services.gnome3.seahorse.enable = true; }
  );
}
