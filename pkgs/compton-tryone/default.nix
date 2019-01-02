{ compton, fetchFromGitHub }:

compton.overrideAttrs (super: rec {
    name = "compton-tryone-${super.version}";

    src = fetchFromGitHub {
        owner = "tryone144";
        repo = "compton";
        rev = "a770a4543058620999d5f259cd190cfb98763e6c";
        sha256 = "1s0yzxmkfrvsd6jf5nd8bnynvsyhlfhj18ysk2gqsdl6dyrm7kjh";
    };

    patches = [
        ./0001-opengl-fixing-error-regarding-missing-format-string.patch
    ];
})
