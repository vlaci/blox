{ lib, ... }: with lib;

{
  imports = [
    ./development
    ./workstation
    ./shell
    ./keepass.nix
    ./nixpkgs.nix
  ];
}
