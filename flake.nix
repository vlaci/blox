{
  description = "vlaci's NixOs configuration";

  edition = 201909;

  inputs = {
    nixpkgs.url = "nixpkgs/release-20.03";
    nixos-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:rycee/home-manager/bqv-flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      flake = false;
    };

    nix-doom-emacs = {
      url = "/home/vlaci/git/github.com/vlaci/nix-doom-emacs";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    mkNixosConfiguration = { modules, system ? "x86_64-linux" }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs.inputs = (builtins.removeAttrs inputs [ "self" ]) // { inherit system; };
      modules = [
        nixpkgs.nixosModules.notDetected
        ({ pkgs, ... }: {
          nix = {
            package = pkgs.nixFlakes;
            extraOptions = ''
              experimental-features = nix-command flakes ca-references
            '';
          };
        })
        self.nixosModules.blox
      ] ++ modules;
    };
  in {
    nixosModules.blox = {
      imports = [
        ./.
      ];
    };

    lib = { inherit mkNixosConfiguration; };
  };
}
