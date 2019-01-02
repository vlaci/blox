{ config, lib, ... }: with lib;

let
  cfg = config.blox.profiles.sshd;
in {
  options.blox.profiles.sshd.enable = mkEnableOption "Use sshd with default configuration";
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
