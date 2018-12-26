{ lib, ... }: with lib;

{
  nixpkgs.config = mkOverride 100 {
    allowUnfree = true;
  };
}
