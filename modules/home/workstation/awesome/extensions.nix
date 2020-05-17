{stdenv, fetchFromGitHub}:

{
  awpwkb = stdenv.mkDerivation rec {
    name = "awpwkb";
    src = fetchFromGitHub {
      # https://github.com/vladimir-g/awpwkb
      owner = "vladimir-g";
      repo = "awpwkb";
      rev = "42ce6e5fc89b5333cd45e7c06cf32f8ef35c03a5";
      sha256 = "11bhx7ldykjxygb5qp7y2mkazxbavi5k9f71z4a1z8s2f8vz6k5j";
    };

    installPhase = ''
      mkdir -p $out/share/lua/5.2
      cp -a . $out/share/lua/5.2/${name}
    '';
  };
  lain = stdenv.mkDerivation rec {
    name = "lain";
    src = fetchFromGitHub {
      owner = "lcpz";
      repo = "lain";
      rev = "71ca1bd76739f5d4f11cc065f2943f1cb87627ab";
      sha256 = "021bcb71hdq6l60pc5z9hpdljs0g0w7ivz72m97ds7md3cpvqfqc";
    };

    installPhase = ''
      mkdir -p $out/share/lua/5.2
      cp -a . $out/share/lua/5.2/${name}
    '';
  };
  sharedtags = stdenv.mkDerivation rec {
    name = "sharedtags";
    src = fetchFromGitHub {
      owner = "Drauthius";
      repo = "awesome-sharedtags";
      rev = "32d878d0d12bcfd900f2c6a7516a1370e6ebb7d6";
      sha256 = "0js6v2jmkczi3g8j7vbk9hsq5wfz96jnhi7ka5c1rqw22lmjmlrk";
    };

    installPhase = ''
      mkdir -p $out/share/lua/5.2
      cp -a . $out/share/lua/5.2/${name}
    '';
  };
}
