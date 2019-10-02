 { config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.docker;
in {
  options.blox.profiles.docker.enable = mkEnableOption "docker";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.docker_compose ];
    virtualisation.docker = {
      enable = true;
      package = pkgs.docker-edge;
    };
    blox.users.defaultGroups = ["docker"];
  };
}
