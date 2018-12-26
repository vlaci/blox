{ config, lib, ... }: with lib;

let
  cfg = config.blox.features.sshd;
in {
  options.blox.features.sshd.enable = mkEnableOption "Use sshd with default configuration";
  config = mkIf cfg.enable {
    services.openssh = mkDefault {
      enable = true;
      forwardX11 = true;
      passwordAuthentication = true;
      permitRootLogin = "no";
      startWhenNeeded = true;
    };
  };
}
