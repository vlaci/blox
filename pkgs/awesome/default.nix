{ fetchFromGitHub, awesome, xterm }:

(awesome.override { compton = xterm; }).overrideAttrs (attrs: rec {
  name = "awesome";
  version = "4.3~master";
  cmakeFlags = "-DOVERRIDE_VERSION=${version}";
  src = fetchFromGitHub {
    owner = "awesomewm";
    repo = "awesome";
    rev = "2308509f39e2d5a50ecab862f68b3728d1596711";
    sha256 = "0ls6gngx36sb9n31i0sm2qmgg62yxxagc4sd8xyzk9vbdmp9gir1";
  };

  LUA_PATH  = "?.lua;" + attrs.LUA_PATH;
})
