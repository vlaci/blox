{ config, lib, nixosConfig, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.workstation;
in {
  options.blox.profiles.workstation.compositor.enable = mkOption {
    description = "Whether to enable compositing.";
    default = !(hasAttr "vm" nixosConfig.system.build);  # Disable in VMs by default
    defaultText = "!nixosConfig.system.build.vm";
    type = types.bool;
  };

  config = mkIf (cfg.enable && cfg.compositor.enable) {
    home.packages = with pkgs; [
      bloxpkgs.compton-tryone
    ];
    home.file.".config/compton.conf".source = ./compton.conf;
  };
}
