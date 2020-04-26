# blox

This repository contains the common parts of my NixOS and home-manager
configuration organized as [NIxOS
modules](https://nixos.org/nixos/manual/index.html#sec-writing-modules).

## Rationale

There are a couple of common configuration settings across my NixOS machines so
I have decided to organize them in an independent repository

## TL; DR

This configuration is intended to use with the currently developed flake system.

1. Add an input to your configuration's `flake.nix`

    ```nix
    {
      description = "vlaci's NixOS machines";
      edition = 201909;

      inputs.blox.url = "git:github.com/blox/flake";

      outputs = { self, nixpkgs, blox }: {
        nixosConfigurations.my-machine = blox.lib.mkNixosConfiguration {
          modules = [
            /path/to/configuration.nix
          ];
        };
      };
    }
    ```

1. Edit your `configuration.nix` file to import `blox`

    ```nix
    { pkgs, ... }:

    {
      networking.hostName = "razorback";

      imports = [
        ./hardware-configuration.nix
      ];

      blox = {
        profiles = {
          development.python.enable = true;
          networkmanager.enable = true;
          docker.enable = true;
          tmux.enable = true;
          zsh.enable = true;
          workstation.enable = true;
        };
        i18n.lang = "hu";
        i18n.xlayout = "hu,us";
        users.users.vlaci = {
          isAdmin = true;
          initialHashedPassword = "....";
        };
      };

      blox.home-manager.config =
        { pkgs, ... }:
        {
          blox.profiles.keepass.enable = true;

          home.packages = with pkgs; [
            vscode
          ];
        }
      ;

      home-manager.users.vlaci.programs.git = {
        enable = true;
        userName = "László Vaskó";
        userEmail = "vlaci@noreply.github.com";
      };
    }
    ```

1. Rebuild NixOS

    ```console
    $ sudo nixos-rebuild switch
    building the system configuration...
    [119 built, 35 copied (404.4 MiB), 89.3 MiB DL]
    ```

1. Profit

## [Configuration Reference](./doc/options.md)

The options can be viewed as man page too:

```console
# if you have blox installed and `blox.blox.installDocs is enabled (the default):
man 5 blox-configuration
```
