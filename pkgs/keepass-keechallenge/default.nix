{ stdenv, buildEnv, fetchzip, mono, yubikey-personalization }:

let
  version = "1.5";
  drv = stdenv.mkDerivation {
    name = "keechallenge-${version}";

    src = fetchzip {
      url = "https://github.com/brush701/keechallenge/releases/download/1.5/KeeChallenge_${version}.zip";
      sha256 = "06hgmgi0kjmlv1a56aij5l4gidsrj53wvnbqj4fjnzl5hpnc8ch1";
    };

    installPhase = ''
      mkdir -p $out/lib/dotnet/keepass/
      substitute KeeChallenge.dll.config $out/lib/dotnet/keepass/KeeChallenge.dll.config \
                 --replace libykpers-1.so.1 ${yubikey-personalization}/lib/libykpers-1.so.1
      cp KeeChallenge.dll $out/lib/dotnet/keepass/
    '';
  };
in
  # Mono is required to compile plugin at runtime, after loading.
buildEnv { name = drv.name; paths = [ mono drv ]; }
