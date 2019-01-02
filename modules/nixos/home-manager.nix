{ config, lib, pkgs, ... }: with lib;

{
  imports = [
    <home-manager/nixos>
  ];

  options.blox.home-manager.config = mkOption {
    description = ''
      Global Home Manager configuration.
      It can be specified the same way as in `home-manager.users.<name>`
      and it applies to all regular users (`isNormalUser` attribute is set).

      There are some optional argument available to the global home manager
      modules, namely:

      - *user*: The current user who the configuration is generated for\
      - *nixosConfig*: The global nixos configuration\

      Note that all `profiles` set in the global configuration is inherited
      by home manager and can be explicitly disabled.
    '';
    type = mkOptionType {
      name = "attribute set or function";
      merge = const (map (x: x.value));
      check = x: isAttrs x || isFunction x;
    };
    default = {};
    example = ''
      {
        blox.home-manager.config =
          { pkgs, ... }:
          {
            blox.profiles.keepass.enable = true;

            home.packages = with pkgs; [
              rustup
            ];
          };
      }
    '';
  };

  config = let
    nixosConfig = config;
    makeHM = name: user:
      ({config, options, pkgs, ...}:
      {
        _module.args = {
          inherit nixosConfig user;
        };

        imports = nixosConfig.blox.home-manager.config ++ [
          ../home
        ];
        blox.profiles = genAttrs (
          intersectLists
            (attrNames options.blox.profiles)
            (attrNames nixosConfig.blox.profiles)
          ) (name: nixosConfig.blox.profiles.${name});
      } // user.home-config);
    hmUsers = filterAttrs (name: { isNormalUser, ...}: isNormalUser) config.users.users;
  in {
    home-manager.users = mapAttrs makeHM hmUsers;
  };
}
