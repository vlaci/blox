{ config, lib, options, pkgs, inputs, ... }: with lib;

{
  nixpkgs.config = mkOverride 100 {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    (self: super:
    let
      callPackage = pkgs.newScope super;
      pkgs = super;
      bloxpkgs = import ../../pkgs { inherit pkgs; };
      mozilla = import "${inputs.nixpkgs-mozilla}/package-set.nix" { inherit pkgs; };
      unstable = import inputs.nixos-unstable {
        config = config.nixpkgs.config;
        system = inputs.system;
        # do not apply overlays recursively as it would introduce infinite recursion
        overlays = [];
      };
    in {
      bloxpkgs = bloxpkgs // { inherit mozilla unstable; };
    })
  ];
}
