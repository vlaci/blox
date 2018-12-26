{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.features.networkmanager;
in {
  options.blox.features.networkmanager.enable = mkEnableOption "Networkmanager with sane defaults";

  config = mkIf cfg.enable {
    networking.networkmanager = mkDefault {
      enable = true;
      dhcp = "dhcpcd";
      dns = "dnsmasq";

      packages = [
        pkgs.networkmanagerapplet
        pkgs.dhcpcd
      ];
    };

    blox.users.defaultGroups = [ "networkmanager" ];
  };
}
