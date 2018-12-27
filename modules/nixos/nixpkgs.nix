{ config, lib, options, pkgs, ... }: with lib;

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
      mozilla = import <mozilla/package-set.nix> { inherit pkgs; };
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
        # do not apply overlays recursively as it would introduce infinite recursion
        overlays = [];
      };
    in {
      bloxpkgs = bloxpkgs // { inherit mozilla unstable; };
    })
  ];
}
