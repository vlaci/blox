{ lib, pkgs, system, callPackage, fetchFromGitHub, writeScript }:

{
  php-language-server = callPackage ./php-language-server { noDev = true; };
  composer2nix = (import (fetchFromGitHub {
    owner = "svanderburg";
    repo = "composer2nix";
    rev = "f0aa6db6b67a7df32077e0d416cb29877c4f5360";
    sha256 = "0z4wcxwxcq53g8zaf4ca7916rhbi06f79bh0bryqyss578693xa3";
    }) { inherit pkgs system; noDev = true; }).override { executable = true; };
}
