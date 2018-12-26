{ stdenv }:

stdenv.mkDerivation rec {
  name = "pixelfun-${version}";
  version = "3.2.1";

  unpackPhase = ''
    tar -xf ${./168338-pixelfun3.tar.gz}
  '';
  installPhase = ''
    cd pixelfun3
    target=$out/share/icons/pixelfun3
    mkdir -p $target
    cp -r * $target
  '';

  meta = {
    description = "Minimalistic cursor theme with a piece of old-school";
    homepage = https://www.gnome-look.org/p/999913/;
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.all;
  };
}
