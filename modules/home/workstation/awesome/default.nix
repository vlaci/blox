{ pkgs, ... }:

{
  home.file = {
    ".config/awesome".source = ./config;
  };

  xsession = {
    enable = true;
    scriptPath = ".xsession-hm";
    windowManager.awesome = with pkgs; let
      modules = callPackage ./extensions.nix { }; in {
        enable = true;
        package = bloxpkgs.latest.awesome;
        luaModules = [ modules.lain modules.sharedtags ];
    };
  };
}
