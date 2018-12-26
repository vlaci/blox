 { config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.features.libvirt;
in {
  options.blox.features.libvirt.enable = mkEnableOption "libvirt";

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = mkDefault true;
    blox.users.defaultGroups = [ "libvirtd" ];

    environment.systemPackages = mkIf config.blox.features.workstation.enable (with pkgs; [
      spice-gtk    # For usb redirection to work we need spice-client-glib-usb-acl-helper from this package TODO: is it need to be present here?
      virtmanager  # TODO: revise if it should be systemwide
    ]);
    security.wrappers = mkIf config.blox.features.workstation.enable {
      spice-client-glib-usb-acl-helper.source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
    };
  };
}
