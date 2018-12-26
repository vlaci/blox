{ config, pkgs, ... }:

rec {
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
  mozilla = import <mozilla/package-set.nix> { inherit pkgs; };

  awesome               = pkgs.callPackage ./awesome               { };
  vscode                = pkgs.callPackage ./vscode                { };

  compton-tryone        = pkgs.callPackage ./compton-tryone        { };
  material-design-icons = pkgs.callPackage ./material-design-icons { };
  pixelfun              = pkgs.callPackage ./pixelfun              { };
  vimPlugins            = pkgs.callPackage ./vimPlugins            { };
}
