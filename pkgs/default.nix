{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) callPackage;
in {
  latest.awesome        = callPackage ./awesome               { };
  latest.vscode         = callPackage ./vscode                { };
  compton-tryone        = callPackage ./compton-tryone        { };
  material-design-icons = callPackage ./material-design-icons { };
  pixelfun              = callPackage ./pixelfun              { };
  vimPlugins            = callPackage ./vimPlugins            { };
  phpPackages           = callPackage ./phpPackages           { };
}
