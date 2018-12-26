{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "material-design-icons-${version}";
  version = "2.1.19";
  cmakeFlags = "-DOVERRIDE_VERSION=${version}";

  src = fetchFromGitHub {
    owner  = "Templarian";
    repo   = "MaterialDesign-Webfont";
    rev    = "v${version}";
    sha256 = "0jyjb9a44c9lm45x07gba75badfaas7cgdfhv8am7vwy88fsxhjz";
  };

  buildCommand = ''
    mkdir -p $out/share/fonts/truetype
    install -D -m644 "$src/fonts/materialdesignicons-webfont.ttf" "$out/share/fonts/truetype/MaterialDesignIcons.ttf"
  '';
}
