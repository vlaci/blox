{ lib, pkgs, system, callPackage, fetchFromGitHub, writeScript }:

{
  php-language-server = callPackage ./php-language-server { noDev = true; };
  phpactor = callPackage ./phpactor { noDev = true; };
  composer2nix = (import (fetchFromGitHub {
    owner = "svanderburg";
    repo = "composer2nix";
    rev = "v0.0.3";
    sha256 = "1xa4qrknzz74fxqqihh7san56sq2wiy39n282zrid8zm4y2yl4s6";
  }) { inherit system; pkgs = (pkgs.extend (se: su: { php = se.php72; })); noDev = true; }).override { executable = true; };
}
