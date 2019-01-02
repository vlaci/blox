{stdenv, fetchFromGitHub}:

{
  lain = stdenv.mkDerivation rec {
    name = "lain";
    src = fetchFromGitHub {
      owner = "lcpz";
      repo = "lain";
      rev = "5f1d675dfabe09c56cc3f621ed76d17b29e2bae0";
      sha256 = "1agjd2m0zgz9bjd7pv3g8zzhfvr6p2bg5va28cz8dn1r4x3q5f7q";
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
      rev = "a57996d1d5f0c080ccaa559bb5a9813fdbcd56f4";
      sha256 = "0sjg0hiyk7vad59a7k8ghwd2p7rjx2wx4h5b64i9cv6idqcrvaa9";
    };

    patches = [
      ./0001-tags-allow-setting-icons-from-tag-definition.patch
    ];

    installPhase = ''
      mkdir -p $out/share/lua/5.2
      cp -a . $out/share/lua/5.2/${name}
    '';
  };
}
