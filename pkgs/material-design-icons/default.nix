{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "material-design-icons-${version}";
  version = "3.2.89";

  src = fetchFromGitHub {
    owner  = "Templarian";
    repo   = "MaterialDesign-Webfont";
    rev    = "v${version}";
    sha256 = "1rxaiiij96kqncsrlkyp109m36v28cgxild7z04k4jh79fvmhjvn";
  };

  buildCommand = ''
    mkdir -p $out/share/fonts/{eot,svg,truetype,woff,woff2}
    cp $src/fonts/*.eot $out/share/fonts/eot/
    cp $src/fonts/*.svg $out/share/fonts/svg/
    cp $src/fonts/*.ttf $out/share/fonts/truetype/
    cp $src/fonts/*.woff $out/share/fonts/woff/
    cp $src/fonts/*.woff2 $out/share/fonts/woff2/
  '';
}
