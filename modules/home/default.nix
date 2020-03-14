{ lib, ... }: with lib;

{
  imports = [
    ./development
    ./doom-emacs
    ./workstation
    ./shell
    ./gpg.nix
    ./pass.nix
    ./keepass.nix
    ./nixpkgs.nix
  ];
}
