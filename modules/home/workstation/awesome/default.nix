{ pkgs, bloxpkgs, ... }:

{
  home.file = {
    ".config/awesome".source = ./config;
  };

  xsession = {
    enable = true;
    scriptPath = ".xsession-hm";
    windowManager.awesome = let
      modules = pkgs.callPackage ./extensions.nix { }; in {
        enable = true;
        package = bloxpkgs.awesome;
        luaModules = [ modules.lain modules.sharedtags ];
    };
  };
}
