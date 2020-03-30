{ stdenv, lib, fetchFromGitHub, pkgconfig, asciidoc, docbook_xml_dtd_45
, docbook_xsl, libxslt, libxml2, makeWrapper
, xorgproto, libxcb ,xcbutilrenderutil, xcbutilimage, pixman, libev
, dbus, libconfig, libdrm, libGL, pcre, libX11, libXcomposite, libXdamage
, libXinerama, libXrandr, libXrender, libXext, xwininfo, libxdg_basedir }:

stdenv.mkDerivation rec {
    name = "compton-tryone";

    src = fetchFromGitHub {
        owner = "tryone144";
        repo = "compton";
        rev = "a770a4543058620999d5f259cd190cfb98763e6c";
        sha256 = "1s0yzxmkfrvsd6jf5nd8bnynvsyhlfhj18ysk2gqsdl6dyrm7kjh";
    };

    patches = [
        ./0001-opengl-fixing-error-regarding-missing-format-string.patch
    ];

    nativeBuildInputs = [
      pkgconfig
      asciidoc
      docbook_xml_dtd_45
      docbook_xsl
      makeWrapper
    ];

    buildInputs = [
      dbus libX11 libXcomposite libXdamage libXrender libXrandr libXext
      libXinerama libdrm pcre libxml2 libxslt libconfig libGL
    ];

    installFlags = [ "PREFIX=$(out)" ];

    postInstall = ''
      wrapProgram $out/bin/compton-trans \
        --prefix PATH : ${lib.makeBinPath [ xwininfo ]}
    '';
}
