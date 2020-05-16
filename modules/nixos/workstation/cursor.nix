# from https://github.com/NixOS/nixpkgs/issues/22652#issuecomment-347072104
{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.services.xserver.displayManager.lightdm.greeters.enso;
in {
  config = let
    # Not sure if this will work when changed, but this is a good default.
    theme = cfg.iconTheme.package;
    icons = cfg.theme.package;
    cursors = cfg.cursorTheme.package;

    # This is adapted from `<nixpkgs>/nixos/modules/services/x11/display-managers/lightdm-greeters/gtk.nix`
    wrappedEnsoGreeter = pkgs.runCommand "lightdm-enso-os-greeter" {
        buildInputs = [ pkgs.makeWrapper ];
        preferLocalBuild = true;
      } ''
        # This wrapper ensures that we actually get themes
        makeWrapper ${pkgs.lightdm-enso-os-greeter}/bin/pantheon-greeter \
          $out/greeter \
          --prefix PATH : "${pkgs.glibc.bin}/bin" \
          --set GDK_PIXBUF_MODULE_FILE "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache" \
          --set GTK_PATH "${theme}:${pkgs.gtk3.out}" \
          --set GTK_EXE_PREFIX "${theme}" \
          --set GTK_DATA_PREFIX "${theme}" \
          --set XDG_DATA_DIRS "${theme}/share:${icons}/share:${cursors}/share" \
          --set XDG_CONFIG_HOME "${theme}/share" \
          --set XCURSOR_PATH "/run/current-system/sw/share/icons"

        cat - > $out/lightdm-enso-os-greeter.desktop << EOF
        [Desktop Entry]
        Name=LightDM Greeter
        Comment=This runs the LightDM Greeter
        Exec=$out/greeter
        Type=Application
        EOF
      '';
  in mkMerge [
    (mkIf (cfg.enable && cfg.cursorTheme != null) {
      environment.pathsToLink = [ "/share" ];
      environment.systemPackages = [
        cfg.cursorTheme.package

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
            Inherits=${cfg.cursorTheme.name}
            EOF
          '';
        }) {})
      ];
    })
    # COMPAT: NixOS >= 20.03
    (mkIf (builtins.compareVersions config.system.nixos.release "20.03" == -1)  {
      services.xserver.displayManager.lightdm.greeter.package = mkForce wrappedEnsoGreeter;
    })
  ];
}
