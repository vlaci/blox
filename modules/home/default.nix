{ lib, ... }: with lib;

{
  imports = [
    ./development
    ./emacs
    ./workstation
    ./shell
    ./keepass.nix
    ./nixpkgs.nix
  ];
}
