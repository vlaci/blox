{ config, lib, ...}: with lib;

let
  cfg = config.blox.users;
  user = name: attrs@{isNormalUser ? true, createHome ? true, ...}:
    attrs // {
      inherit isNormalUser createHome;
    }
  ;
in {
  options.blox.users = {
    defaultGroups = mkOption {
      description = "Groups added by profiles";
      internal = true;
      visible = false;
      type = with types; listOf str;
      default = [];
    };

    users = mkOption {
      description = "Users with sane defaults";
      type = with types; loaOf attrs;
      apply = mapAttrs user;
      default = [];
    };
  };

  options.users.users = mkOption {
    type = with types; loaOf (submodule ({ name, config, ... }: {
      options = {
        extraGroups = mkOption {
          apply = groups: if config.isNormalUser then
            cfg.defaultGroups ++ groups
          else
            groups;
        };
        isAdmin = mkEnableOption "sudo access";
        home-config = mkOption {
          description = "Extra home manager configuration to be defined inline";
          type = types.attrs;
          default = {};
        };
      };
      config = {
        extraGroups = if config.isAdmin then ["wheel" ] else [];
      };
    }));
  };

  config = {
    users = {
      mutableUsers = mkDefault false;
      users = cfg.users;
    };
  };
}
