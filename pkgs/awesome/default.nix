{ fetchFromGitHub, awesome, xterm }:

awesome.overrideAttrs (attrs: rec {
  name = "awesome";
  version = "4.4~git";
  cmakeFlags = "-DOVERRIDE_VERSION=${version}";
  src = fetchFromGitHub {
    owner = "awesomewm";
    repo = "awesome";
    rev = "814d701c81f24bcd5e55e3ee6d6d0c1e9fd53905";
    sha256 = "1c5vynd7lh56wlhy53ibdzc56x6kx72qx3z6xpzjxgpsayryli1x";
  };
})
