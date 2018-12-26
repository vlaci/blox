 { config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.features.docker;
in {
  options.blox.features.docker.enable = mkEnableOption "docker";

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      package = pkgs.docker-edge;
    };
    blox.users.defaultGroups = ["docker"];
  };
}
