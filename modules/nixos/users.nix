{ options, config, lib, ...}: with lib;

let
  cfg = config.blox.users;
  user = name: attrs@{isNormalUser ? true, createHome ? true, ...}:
    attrs // {
      inherit isNormalUser createHome;
    }
  ;
  defaultUsers = { root = { isNormalUser = false; }; };
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
      default = defaultUsers;
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
      };
      config = {
        extraGroups = if config.isAdmin then ["wheel" ] else [];
      };
    }));
  };

  config = {
    blox.users.users = defaultUsers;

    users = {
      mutableUsers = mkDefault false;
      users = cfg.users;
    };
  };
}
