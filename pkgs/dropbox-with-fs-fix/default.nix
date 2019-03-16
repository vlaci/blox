{ stdenv, fetchFromGitHub, dropbox, makeWrapper }:

stdenv.mkDerivation {
  name = "dropbox-filesystem-fix";
  src = fetchFromGitHub {
    owner = "dark";
    repo = "dropbox-filesystem-fix";
    rev = "d284f5d4884003c2dad24eac88b5e285f6281624";
    sha256 = "0a5gfb11nb26lpavppyfifklnw515sg402sy9cqm8h39gw2zkb87";
  };
  buildInputs = [ dropbox makeWrapper ];
  installPhase = ''
    mkdir -p $out/{lib,share/applications}
    cp libdropbox_fs_fix.so $out/lib
    ln -sn ${dropbox}/share/applications $out/share/applications
    makeWrapper ${dropbox}/bin/dropbox $out/bin/dropbox --prefix LD_PRELOAD : $out/lib/libdropbox_fs_fix.so
  '';
}
