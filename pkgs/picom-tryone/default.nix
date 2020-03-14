{ fetchFromGitHub, picom }:

picom.overrideAttrs (super: {
  version = "7.5-1";
    src = fetchFromGitHub {
        owner = "tryone144";
        repo = "compton";
        rev = "e01494c0cb34dcb4e954a1d2542f5de922fcb01d";
        sha256 = "0s153fqw3r79jk37qs1jwg72hkrcjrg51xpv0zf5yg77h2vxck2m";
        fetchSubmodules = true;
    };
})
