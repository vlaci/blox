# from https://github.com/NixOS/nixpkgs/issues/22652#issuecomment-347072104
{ config, lib, pkgs, ... }:

let
  cfg = config.services.xserver.displayManager.lightdm.greeters.gtk;
in {
  options = {
    services.xserver.displayManager.lightdm.greeters.gtk.cursor = lib.mkOption {
      description = "Cursor theme to use";
      default = null;
      example = ''
        {
          name = "Numix-Cursor";
          package = pkgs.numix-cursor-theme;
        }
      '';
      type = with lib; with lib.types; nullOr (submodule {
        options = {
          name = mkOption {
            description = "Cursor theme name";
            type = str;
          };
          package = mkOption {
            description = "Cursor theme package";
            type = package;
          };
        };
      });
     };
  };

  config = let
    # Not sure if this will work when changed, but this is a good default.
    theme = cfg.iconTheme.package;
    icons = cfg.theme.package;

    # This is adapted from `<nixpkgs>/nixos/modules/services/x11/display-managers/lightdm-greeters/gtk.nix`
    wrappedGtkGreeter = pkgs.runCommand "lightdm-gtk-greeter"
      { buildInputs = [ pkgs.makeWrapper ]; }
      ''
        # This wrapper ensures that we actually get themes
        makeWrapper ${pkgs.lightdm_gtk_greeter}/sbin/lightdm-gtk-greeter \
          $out/greeter \
          --prefix PATH : "${pkgs.glibc.bin}/bin" \
          --set GDK_PIXBUF_MODULE_FILE "${pkgs.gdk_pixbuf.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache" \
          --set GTK_PATH "${theme}:${pkgs.gtk3.out}" \
          --set GTK_EXE_PREFIX "${theme}" \
          --set GTK_DATA_PREFIX "${theme}" \
          --set XDG_DATA_DIRS "${theme}/share:${icons}/share" \
          --set XDG_CONFIG_HOME "${theme}/share" \
          --set XCURSOR_PATH "/run/current-system/sw/share/icons" \
          --set XCURSOR_SIZE "64"
        cat - > $out/lightdm-gtk-greeter.desktop << EOF
        [Desktop Entry]
        Name=LightDM Greeter
        Comment=This runs the LightDM Greeter
        Exec=$out/greeter
        Type=Application
        EOF
      '';
  in lib.mkIf (cfg.enable && cfg.cursor != null) {
    environment.pathsToLink = [ "/share" ];
    environment.systemPackages = [
      cfg.cursor.package

      # Adds a package defining a default icon/cursor theme.
      # Based off of: https://github.com/NixOS/nixpkgs/pull/25974#issuecomment-305997110
      (pkgs.callPackage ({ stdenv }: stdenv.mkDerivation {
        name = "global-cursor-theme";
        unpackPhase = "true";
        outputs = [ "out" ];
        installPhase = ''
          mkdir -p $out/share/icons/default
          cat << EOF > $out/share/icons/default/index.theme
          [Icon Theme]
          Name=Default
          Comment=Default Cursor Theme
          Inherits=${cfg.cursor.name}
          EOF
        '';
      }) {})
    ];

    services.xserver.displayManager.lightdm.greeter.package = lib.mkOptionDefault wrappedGtkGreeter;
  };
}
