{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) callPackage;
in {
  latest.awesome        = callPackage ./awesome               { };
  latest.vscode         = callPackage ./vscode                { };
  compton-tryone        = callPackage ./compton-tryone        { };
  dropbox-with-fs-fix   = callPackage ./dropbox-with-fs-fix   { };
  keepass-keechallenge  = callPackage ./keepass-keechallenge  { };
  pixelfun              = callPackage ./pixelfun              { };
  vimPlugins            = callPackage ./vimPlugins            { };
  phpPackages           = callPackage ./phpPackages           { };
  nodePackages          = callPackage ./nodePackages          { };
}
