{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) callPackage;
in {
  latest.vscode         = callPackage ./vscode                { };
  compton-tryone        = callPackage ./compton-tryone        { };
  keepass-keechallenge  = callPackage ./keepass-keechallenge  { };
  material-design-icons = callPackage ./material-design-icons { };
  pixelfun              = callPackage ./pixelfun              { };
  vimPlugins            = callPackage ./vimPlugins            { };
  phpPackages           = callPackage ./phpPackages           { };
}
