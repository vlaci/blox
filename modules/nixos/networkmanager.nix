{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.networkmanager;
in {
  options.blox.profiles.networkmanager.enable = mkEnableOption "Networkmanager with sane defaults";

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
