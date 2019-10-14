{ pkgs ? import <nixpkgs> { } }:

let
  inherit (builtins) filter;
  inherit (pkgs) lib callPackage mkShell writeShellScriptBin;

  awesome-test = writeShellScriptBin "awesome-test" ''
    export GUEST_DISPLAY=:10
    ${pkgs.xorg.xorgserver}/bin/Xephyr -br -ac -noreset -screen 1280x1000 $GUEST_DISPLAY &
    export DISPLAY=$GUEST_DISPLAY
    X_PID=$!
    trap "kill $X_PID || true" EXIT
    sleep 1
    ${pkgs.awesome}/bin/awesome -c config/rc.lua --search config ${makeSearchPath (filter (x: lib.isDerivation x) (lib.attrValues extensions))}
  '';

  extensions = callPackage ./extensions.nix { };

  # From https://github.com/rycee/home-manager/blob/master/modules/services/window-managers/awesome.nix
  makeSearchPath = lib.concatMapStrings (path:
    " --search ${getLuaPath path "share"}"
    + " --search ${getLuaPath path "lib"}"
    );
  getLuaPath = lib: dir: "${lib}/${dir}/lua/${pkgs.luaPackages.lua.luaversion}";

  drv = mkShell {
    buildInputs = with pkgs; [
      awesome-test
    ];
    shellHook = ''
      echo 'Run `awesome-test` to try out current configuration'
    '';
  };
in
  drv

