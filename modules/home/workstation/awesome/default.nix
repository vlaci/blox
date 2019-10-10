{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.workstation.awesome;
in {
  options.blox.profiles.workstation.awesome = {
    enable = mkOption {
      description = "Whether to install Awesome WM.";
      type = types.bool;
      default = true;
    };
    configure = mkOption {
      description = "Whether to configure Awesome WM to blox defaults.";
      type = types.bool;
      default = true;
    };
  };

  config = {
    home.file = mkIf cfg.configure {
      ".config/awesome".source = mkDefault ./config;
    };

    xsession = mkIf cfg.enable {
      enable = true;
      scriptPath = ".xsession-hm";
      windowManager.awesome = with pkgs; let
        modules = callPackage ./extensions.nix { }; in {
          enable = true;
          package = if builtins.compareVersions awesome.version "4.3" >= 0 then
              awesome
            else
              bloxpkgs.unstable.awesome
            ;
          luaModules = [ modules.lain modules.sharedtags ];
      };
    };
  };
}
