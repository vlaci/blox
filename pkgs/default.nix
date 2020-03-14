{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) callPackage;
in {
  latest.vscode         = callPackage ./vscode                { };
  dropbox-with-fs-fix   = callPackage ./dropbox-with-fs-fix   { };
  keepass-keechallenge  = callPackage ./keepass-keechallenge  { };
  picom-tryone          = callPackage ./picom-tryone          { };
  pixelfun              = callPackage ./pixelfun              { };
  vimPlugins            = callPackage ./vimPlugins            { };
  phpPackages           = callPackage ./phpPackages           { };
}
