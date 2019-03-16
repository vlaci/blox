{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) callPackage;
in {
  latest.vscode         = callPackage ./vscode                { };
  compton-tryone        = callPackage ./compton-tryone        { };
  dropbox-with-fs-fix   = callPackage ./dropbox-with-fs-fix   { };
  keepass-keechallenge  = callPackage ./keepass-keechallenge  { };
  material-design-icons = callPackage ./material-design-icons { };
  pixelfun              = callPackage ./pixelfun              { };
  vimPlugins            = callPackage ./vimPlugins            { };
  phpPackages           = callPackage ./phpPackages           { };
}
