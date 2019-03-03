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
        package = if builtins.compareVersions awesome.version "4.3" >= 0 then
            awesome
          else
            bloxpkgs.unstable.awesome
          ;
        luaModules = [ modules.lain modules.sharedtags ];
    };
  };
}
