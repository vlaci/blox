{ lib, pkgs, system, callPackage, fetchFromGitHub, writeScript }:

{
  php-language-server = callPackage ./php-language-server { noDev = true; };
  phpactor = callPackage ./phpactor { noDev = true; };
  composer2nix = (import (fetchFromGitHub {
    owner = "svanderburg";
    repo = "composer2nix";
    rev = "v0.0.4";
    sha256 = "0q0x3in43ss1p0drhc5lp5bnp2jqni1i7zxm7lmjl5aad9nkn3gf";
  }) { inherit system pkgs; noDev = true; }).override { executable = true; };
}
