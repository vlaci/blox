{ lib, ... }: with lib;

{
  imports = [
    ./development
    ./doom-emacs
    ./workstation
    ./shell
    ./keepass.nix
    ./nixpkgs.nix
  ];
}
