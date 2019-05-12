{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "composer/xdebug-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-xdebug-handler-d17708133b6c276d6e42ef887a877866b909d892";
        src = fetchurl {
          url = https://api.github.com/repos/composer/xdebug-handler/zipball/d17708133b6c276d6e42ef887a877866b909d892;
          sha256 = "1y7y4bdn867g8mhcg4hg9ivwzvxv4cxbznr3swcf5z4frliwkg92";
        };
      };
    };
    "felixfbecker/advanced-json-rpc" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "felixfbecker-advanced-json-rpc-241c470695366e7b83672be04ea0e64d8085a551";
        src = fetchurl {
          url = https://api.github.com/repos/felixfbecker/php-advanced-json-rpc/zipball/241c470695366e7b83672be04ea0e64d8085a551;
          sha256 = "0pwb1826sf01wv9baziqavd3465629dlnmz9a0slipgcs494znjv";
        };
      };
    };
    "felixfbecker/language-server" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "felixfbecker-language-server-1da3328bc23ebd6418529035d357481c8c028640";
        src = fetchurl {
          url = https://api.github.com/repos/felixfbecker/php-language-server/zipball/1da3328bc23ebd6418529035d357481c8c028640;
          sha256 = "0958bsdipzvhfhxlc1arpr3yf5g6dmq5vw5ms8784jq000s7bbik";
        };
      };
    };
    "felixfbecker/language-server-protocol" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "felixfbecker-language-server-protocol-1bdd1bcc95428edf85ec04c7b558d0886c07280f";
        src = fetchurl {
          url = https://api.github.com/repos/felixfbecker/php-language-server-protocol/zipball/1bdd1bcc95428edf85ec04c7b558d0886c07280f;
          sha256 = "0w9gd41dpw5380jrbdgry8kv1amaraf38lcm1vcclnhmck0xa9da";
        };
      };
    };
    "jetbrains/phpstorm-stubs" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jetbrains-phpstorm-stubs-d1ecf6422d5b5717efacd6bc45af65a8f83bb668";
        src = fetchurl {
          url = https://api.github.com/repos/JetBrains/phpstorm-stubs/zipball/d1ecf6422d5b5717efacd6bc45af65a8f83bb668;
          sha256 = "1k26da95h82ivin0dmrmgjmq9ljrsb9fhgfncvnq3bwjdsnmm2vd";
        };
      };
    };
    "microsoft/tolerant-php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "microsoft-tolerant-php-parser-b662587eb797685a98239d1d52d25168a03fdfb2";
        src = fetchurl {
          url = https://api.github.com/repos/Microsoft/tolerant-php-parser/zipball/b662587eb797685a98239d1d52d25168a03fdfb2;
          sha256 = "1jxgg8q494jrfxzgflfy6j0f9zkvd0c42dkrnjbrs2g8aq0wxgf8";
        };
      };
    };
    "netresearch/jsonmapper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "netresearch-jsonmapper-3868fe1128ce1169228acdb623359dca74db5ef3";
        src = fetchurl {
          url = https://api.github.com/repos/cweiske/jsonmapper/zipball/3868fe1128ce1169228acdb623359dca74db5ef3;
          sha256 = "0n9f63q18iyblww447skfxya7fi6lsjsnzyvgshq73mfy6vqsjzq";
        };
      };
    };
    "phpdocumentor/reflection-common" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-reflection-common-21bdeb5f65d7ebf9f43b1b25d404f87deab5bfb6";
        src = fetchurl {
          url = https://api.github.com/repos/phpDocumentor/ReflectionCommon/zipball/21bdeb5f65d7ebf9f43b1b25d404f87deab5bfb6;
          sha256 = "1yaf1zg9lnkfnq2ndpviv0hg5bza9vjvv5l4wgcn25lx1p8a94w2";
        };
      };
    };
    "phpdocumentor/reflection-docblock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-reflection-docblock-94fd0001232e47129dd3504189fa1c7225010d08";
        src = fetchurl {
          url = https://api.github.com/repos/phpDocumentor/ReflectionDocBlock/zipball/94fd0001232e47129dd3504189fa1c7225010d08;
          sha256 = "03zvxqb5n9ddvysj8mjdwf59h7sagj5x5z15nhs7mqpcky1w388x";
        };
      };
    };
    "phpdocumentor/type-resolver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-type-resolver-9c977708995954784726e25d0cd1dddf4e65b0f7";
        src = fetchurl {
          url = https://api.github.com/repos/phpDocumentor/TypeResolver/zipball/9c977708995954784726e25d0cd1dddf4e65b0f7;
          sha256 = "0h888r2iy2290yp9i3fij8wd5b7960yi7yn1rwh26x1xxd83n2mb";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-6c001f1daafa3a3ac1d8ff69ee4db8e799a654dd";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/log/zipball/6c001f1daafa3a3ac1d8ff69ee4db8e799a654dd;
          sha256 = "1i351p3gd1pgjcjxv7mwwkiw79f1xiqr38irq22156h05zlcx80d";
        };
      };
    };
    "sabre/event" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sabre-event-f5cf802d240df1257866d8813282b98aee3bc548";
        src = fetchurl {
          url = https://api.github.com/repos/sabre-io/event/zipball/f5cf802d240df1257866d8813282b98aee3bc548;
          sha256 = "1003imr8dl8cdpybkg0r959hl0gipfrnidhp7r60bqfyriwczc9a";
        };
      };
    };
    "sabre/uri" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sabre-uri-a42126042c7dcb53e2978dadb6d22574d1359b4c";
        src = fetchurl {
          url = https://api.github.com/repos/sabre-io/uri/zipball/a42126042c7dcb53e2978dadb6d22574d1359b4c;
          sha256 = "0yzj6fcs11pld8ws89b864ad8p8j2insq2rnlgz3dh4r52xkjrmh";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-e3d826245268269cd66f8326bd8bc066687b4a19";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-ctype/zipball/e3d826245268269cd66f8326bd8bc066687b4a19;
          sha256 = "16md0qmy5jvvl7lc6n6r5hxjdr5i30vl6n9rpkm4b11rh2nqh7mh";
        };
      };
    };
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-83e253c8e0be5b0257b881e1827274667c5c17a9";
        src = fetchurl {
          url = https://api.github.com/repos/webmozart/assert/zipball/83e253c8e0be5b0257b881e1827274667c5c17a9;
          sha256 = "0d84b0ms9mjpqx368gs7c3qs06mpbx5565j3vs43b1ygnyhhhaqk";
        };
      };
    };
    "webmozart/glob" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-glob-3cbf63d4973cf9d780b93d2da8eec7e4a9e63bbe";
        src = fetchurl {
          url = https://api.github.com/repos/webmozart/glob/zipball/3cbf63d4973cf9d780b93d2da8eec7e4a9e63bbe;
          sha256 = "1x5bzc9lyhmh9bf7ji2hs5srz2w7mjk919sm2h68v1x2xn7892s9";
        };
      };
    };
    "webmozart/path-util" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-path-util-d939f7edc24c9a1bb9c0dee5cb05d8e859490725";
        src = fetchurl {
          url = https://api.github.com/repos/webmozart/path-util/zipball/d939f7edc24c9a1bb9c0dee5cb05d8e859490725;
          sha256 = "0zv2di0fh3aiwij0nl6595p8qvm9zh0k8jd3ngqhmqnis35kr01l";
        };
      };
    };
  };
  devPackages = {};
in
composerEnv.buildPackage {
  inherit packages devPackages noDev;
  name = "php-language-server";
  src = ./.;
  executable = true;
  symlinkDependencies = false;
  meta = {};
}