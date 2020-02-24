{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "composer/ca-bundle" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-ca-bundle-47fe531de31fca4a1b997f87308e7d7804348f7e";
        src = fetchurl {
          url = https://api.github.com/repos/composer/ca-bundle/zipball/47fe531de31fca4a1b997f87308e7d7804348f7e;
          sha256 = "0cvmfh4d5v4ws5sc1c9g57wvq5zfxj9biljq586kcl4j43c6pyis";
        };
      };
    };
    "composer/composer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-composer-1291a16ce3f48bfdeca39d64fca4875098af4d7b";
        src = fetchurl {
          url = https://api.github.com/repos/composer/composer/zipball/1291a16ce3f48bfdeca39d64fca4875098af4d7b;
          sha256 = "0314d43x338rsbqkx8gdhk9s6yn8r7jbfh30iwn2bb3asjj0ymjj";
        };
      };
    };
    "composer/semver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-semver-c6bea70230ef4dd483e6bbcab6005f682ed3a8de";
        src = fetchurl {
          url = https://api.github.com/repos/composer/semver/zipball/c6bea70230ef4dd483e6bbcab6005f682ed3a8de;
          sha256 = "11f4az7s736nj8n52wjanlpcpfk8ijx9wii5wmwbylp0s4s20ryd";
        };
      };
    };
    "composer/spdx-licenses" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-spdx-licenses-0c3e51e1880ca149682332770e25977c70cf9dae";
        src = fetchurl {
          url = https://api.github.com/repos/composer/spdx-licenses/zipball/0c3e51e1880ca149682332770e25977c70cf9dae;
          sha256 = "11cbifgnby63qfl7xsp5hs1z4x7s5p2p4yxcbh3m3c5wrp8n8ykl";
        };
      };
    };
    "composer/xdebug-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-xdebug-handler-cbe23383749496fe0f373345208b79568e4bc248";
        src = fetchurl {
          url = https://api.github.com/repos/composer/xdebug-handler/zipball/cbe23383749496fe0f373345208b79568e4bc248;
          sha256 = "0shf0q79fkzqvwpb8gn8fgwpm5bhzj5acwayilgdsasr506jsr2l";
        };
      };
    };
    "dnoegel/php-xdg-base-dir" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dnoegel-php-xdg-base-dir-8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd";
        src = fetchurl {
          url = https://api.github.com/repos/dnoegel/php-xdg-base-dir/zipball/8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd;
          sha256 = "02n4b4wkwncbqiz8mw2rq35flkkhn7h6c0bfhjhs32iay1y710fq";
        };
      };
    };
    "jetbrains/phpstorm-stubs" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jetbrains-phpstorm-stubs-883b6facd78e01c0743b554af86fa590c2573f40";
        src = fetchurl {
          url = https://api.github.com/repos/JetBrains/phpstorm-stubs/zipball/883b6facd78e01c0743b554af86fa590c2573f40;
          sha256 = "1hx3vrqw3k4kp2sjvvckbpn2dghzpacxzs2h4gl09hyj2cdm2rn4";
        };
      };
    };
    "justinrainbow/json-schema" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "justinrainbow-json-schema-44c6787311242a979fa15c704327c20e7221a0e4";
        src = fetchurl {
          url = https://api.github.com/repos/justinrainbow/json-schema/zipball/44c6787311242a979fa15c704327c20e7221a0e4;
          sha256 = "12a75nyv59pd8kx18w7vlsp2xwwjk9ynbzkkx56mcf1payinwpr1";
        };
      };
    };
    "microsoft/tolerant-php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "microsoft-tolerant-php-parser-c5e2bf5d8c9f4f27eef1370bd39ea2d1f374eeb4";
        src = fetchurl {
          url = https://api.github.com/repos/microsoft/tolerant-php-parser/zipball/c5e2bf5d8c9f4f27eef1370bd39ea2d1f374eeb4;
          sha256 = "1rspicyvlh02mbrdvnfazz0b4w9f81kj267m5qldd0dz5lfmzirq";
        };
      };
    };
    "monolog/monolog" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "monolog-monolog-fa82921994db851a8becaf3787a9e73c5976b6f1";
        src = fetchurl {
          url = https://api.github.com/repos/Seldaek/monolog/zipball/fa82921994db851a8becaf3787a9e73c5976b6f1;
          sha256 = "0vcn1j16pjbya65cd3c8wm4383mi96l5ys195ni8nvchna7a6b6v";
        };
      };
    };
    "ocramius/package-versions" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ocramius-package-versions-1d32342b8c1eb27353c8887c366147b4c2da673c";
        src = fetchurl {
          url = https://api.github.com/repos/Ocramius/PackageVersions/zipball/1d32342b8c1eb27353c8887c366147b4c2da673c;
          sha256 = "1bdi6lfb8l4aa9161a2wa72hcqg8j33irv748sbqgz6rpd88m6ns";
        };
      };
    };
    "phpactor/class-mover" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-class-mover-65d283bacb32c7679c4329f6c127f1ebb3ac348f";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/class-mover/zipball/65d283bacb32c7679c4329f6c127f1ebb3ac348f;
          sha256 = "02gglsgwgnm85jc4821cmij5lmyjigrfkm58jrirlb3lfx9a957x";
        };
      };
    };
    "phpactor/class-to-file" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-class-to-file-d4250db8b90026a5888e4c231c5d222794443db8";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/class-to-file/zipball/d4250db8b90026a5888e4c231c5d222794443db8;
          sha256 = "13rkzxdqglqx1ypb72qwrld2jsjdjvwa7x2n2mqdsdk7k36s98b8";
        };
      };
    };
    "phpactor/class-to-file-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-class-to-file-extension-f7bc66301f996f316386eccda642874e3a4d424e";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/class-to-file-extension/zipball/f7bc66301f996f316386eccda642874e3a4d424e;
          sha256 = "015vs850bsfhh0n3i6pb607dkfd21qw2593p81jq218ha742b7b7";
        };
      };
    };
    "phpactor/code-builder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-code-builder-be0bc6f94baa919c078c297e1c4fd0f3a4a424fa";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/code-builder/zipball/be0bc6f94baa919c078c297e1c4fd0f3a4a424fa;
          sha256 = "1qnnp798fq5kqpqgyky3bnz2hfx8clr790zgznfaac7a5xz06h2x";
        };
      };
    };
    "phpactor/code-transform" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-code-transform-ae03b2da4fe845aab70911d017eadd79251a45b8";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/code-transform/zipball/ae03b2da4fe845aab70911d017eadd79251a45b8;
          sha256 = "0cvcn19m5idafqrsqdr4xidi3xs2f7npgjbvmj5azcs56qqviq0i";
        };
      };
    };
    "phpactor/code-transform-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-code-transform-extension-8ae08fd9b51c02b9cbb5f278b88166aafad10472";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/code-transform-extension/zipball/8ae08fd9b51c02b9cbb5f278b88166aafad10472;
          sha256 = "1hb571k6s5cf5pmcwnh2r26qj7h3c8j8lk173qxya3ws9zh9ss8v";
        };
      };
    };
    "phpactor/completion" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-completion-8532f9f43d67149d7db72415133d7a166a6badaa";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/completion/zipball/8532f9f43d67149d7db72415133d7a166a6badaa;
          sha256 = "00vbpsyif5ddf17nhglh4agm49yl622bknwypk9fjvv8527dwz8a";
        };
      };
    };
    "phpactor/completion-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-completion-extension-50229428b5ffba89683b9e3d6f9dbe44c3111eba";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/completion-extension/zipball/50229428b5ffba89683b9e3d6f9dbe44c3111eba;
          sha256 = "03h7j71g18ih3k98wvz6rjx9607qp8xlrsha67gpd0vm2c2kwf33";
        };
      };
    };
    "phpactor/completion-rpc-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-completion-rpc-extension-f43140000878d36280cbdde4f56e362c2f23f546";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/completion-rpc-extension/zipball/f43140000878d36280cbdde4f56e362c2f23f546;
          sha256 = "1hjcgaqqlmjwfrhdpdmyy6gpr330as57i60954rlybcv34h83gdi";
        };
      };
    };
    "phpactor/completion-worse-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-completion-worse-extension-3f381acce7d3e6b936bc9b711559316c210ceff9";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/completion-worse-extension/zipball/3f381acce7d3e6b936bc9b711559316c210ceff9;
          sha256 = "0dbvf1xq6wg6qqmvw135cmkb8dxp4pz1q3fw5mni8zzc9gpmi0ps";
        };
      };
    };
    "phpactor/composer-autoloader-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-composer-autoloader-extension-6ef27b06a49f39db92380833d24d7f92eca363b6";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/composer-autoloader-extension/zipball/6ef27b06a49f39db92380833d24d7f92eca363b6;
          sha256 = "1fy9135vkv7ldzpz8q8li541683n9qdlahy7cncx92mlz0937rqz";
        };
      };
    };
    "phpactor/config-loader" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-config-loader-61db28afa005ac814d7cf48fce70f07e897e038c";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/config-loader/zipball/61db28afa005ac814d7cf48fce70f07e897e038c;
          sha256 = "09zj6ahzanwkf1cfhjl5pjg972mpi3n7xv91qz493kn4zwxll0q5";
        };
      };
    };
    "phpactor/console-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-console-extension-4ee1ec97536b68f55ca03f00427df0c0fcad63f2";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/console-extension/zipball/4ee1ec97536b68f55ca03f00427df0c0fcad63f2;
          sha256 = "0lnkjl3bklqb6xbcb9wa0ijxa859v0cbf7lcj4jm4psbnavvcf96";
        };
      };
    };
    "phpactor/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-container-a69e6f13bd8fd3b227efa7b8bf126aa6ed45f0b8";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/container/zipball/a69e6f13bd8fd3b227efa7b8bf126aa6ed45f0b8;
          sha256 = "1fd54h7z7qkd8a1wk7ysplj560z9w8gbbnpw7v0jqhs7phl4qmxc";
        };
      };
    };
    "phpactor/docblock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-docblock-990d029ee2541ad102c14585c36f2675bafdfbd2";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/docblock/zipball/990d029ee2541ad102c14585c36f2675bafdfbd2;
          sha256 = "0nf3d11zmfc6liy43y395xsck3w1d4v0c8g156800yhj578xblhb";
        };
      };
    };
    "phpactor/extension-manager-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-extension-manager-extension-2c4a888cf6becd344d2958353e9ebc1aad01b26c";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/extension-manager-extension/zipball/2c4a888cf6becd344d2958353e9ebc1aad01b26c;
          sha256 = "10g6kd9rbrrd7qlid7l5fsp74wgf13p9xx1qdrw055pdlzgzaxhc";
        };
      };
    };
    "phpactor/file-path-resolver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-file-path-resolver-74ace7bac0c4fc1a80001152bcc5c66d3d990acb";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/file-path-resolver/zipball/74ace7bac0c4fc1a80001152bcc5c66d3d990acb;
          sha256 = "1g20rxz08xca3r14407ywd2j94mn1fxgsqshf8x5a1jga8ph7v6b";
        };
      };
    };
    "phpactor/file-path-resolver-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-file-path-resolver-extension-457c5c97d75fc8d6bcd0acd5588badc189f81cc6";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/file-path-resolver-extension/zipball/457c5c97d75fc8d6bcd0acd5588badc189f81cc6;
          sha256 = "11l6k6fkm9l77cai66jh12hb4nnvlygb41w3mpaai2r3hcyvfqf0";
        };
      };
    };
    "phpactor/logging-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-logging-extension-306149d2ab1582ff389a71fce45d270f5f7c9ac1";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/logging-extension/zipball/306149d2ab1582ff389a71fce45d270f5f7c9ac1;
          sha256 = "07izms1iqsrzzgcx547wgprh1wz0pcqqc8j3w607vrkxi9cv9pk2";
        };
      };
    };
    "phpactor/map-resolver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-map-resolver-21ef588c9861863d56ffaa7ae19a5e99dc07b30d";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/map-resolver/zipball/21ef588c9861863d56ffaa7ae19a5e99dc07b30d;
          sha256 = "01mp1s2h1l4l9vll21xi8349a6ab8np07vn5hbpjbl4nykyd36dq";
        };
      };
    };
    "phpactor/path-finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-path-finder-14f4c7a658ea501e7679d27bbf5d2abec1a9ad07";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/path-finder/zipball/14f4c7a658ea501e7679d27bbf5d2abec1a9ad07;
          sha256 = "1f8w2jm5cnwbx1sz758zf2g9q2bmgj7r11vqz4axfb0z451rcrdy";
        };
      };
    };
    "phpactor/phpactor" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-phpactor-f3e8d2f2f202f5ee6f277d6c23e6cf7928c952f6";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/phpactor/zipball/f3e8d2f2f202f5ee6f277d6c23e6cf7928c952f6;
          sha256 = "0gk6aczc50d9cixyr7dcmm1s5vpqbdm9fqs0mlnlqkjr62y1rqz2";
        };
      };
    };
    "phpactor/reference-finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-reference-finder-2880e7f416529be9e9442bafcf5521ee373dbd8d";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/reference-finder/zipball/2880e7f416529be9e9442bafcf5521ee373dbd8d;
          sha256 = "1ka3l7giin78zsdjlv22y3aqhw1jm79r9mmf0mza7j3ar5m6mnw6";
        };
      };
    };
    "phpactor/reference-finder-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-reference-finder-extension-b8dbb9123107e90f0ed343679e4642ed57c25a05";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/reference-finder-extension/zipball/b8dbb9123107e90f0ed343679e4642ed57c25a05;
          sha256 = "1k1pbsfh6ydpljrzx5lxv9m6ln3zlx3kbcxfp4afh1sd39h4w6vs";
        };
      };
    };
    "phpactor/reference-finder-rpc-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-reference-finder-rpc-extension-986d69af7669c6c26416f260373dc7db5168c9fd";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/reference-finder-rpc-extension/zipball/986d69af7669c6c26416f260373dc7db5168c9fd;
          sha256 = "0a74qlak23ms2c6jyxyr3dbkcd09i3913gj5vx5l2nr1flsjfhb5";
        };
      };
    };
    "phpactor/rpc-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-rpc-extension-ea5c898bdb0aa707b39ebe664e651e90cd964efe";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/rpc-extension/zipball/ea5c898bdb0aa707b39ebe664e651e90cd964efe;
          sha256 = "1mz6rpplh1sn52w1wpc4gc744wbhkz3hd65gb9zj397r77jj2hrl";
        };
      };
    };
    "phpactor/source-code-filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-source-code-filesystem-8dbb795a20e749783ad10f6d47d8bcbebf60e0ff";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/source-code-filesystem/zipball/8dbb795a20e749783ad10f6d47d8bcbebf60e0ff;
          sha256 = "0d18zk6gn01avfdc9cki465s219ky58gbzxrwki14xgrwxv2mqws";
        };
      };
    };
    "phpactor/source-code-filesystem-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-source-code-filesystem-extension-0a83f0a9c51d3a83b9a3c91290aa822315cb7cf3";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/source-code-filesystem-extension/zipball/0a83f0a9c51d3a83b9a3c91290aa822315cb7cf3;
          sha256 = "0gr073rzbg7k0w4i6b6npp850nknd8nf7w6c53afdcy7sz0b34wi";
        };
      };
    };
    "phpactor/text-document" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-text-document-3ecf1da9607522077eed023433b5efa93c9bc534";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/text-document/zipball/3ecf1da9607522077eed023433b5efa93c9bc534;
          sha256 = "078g7y9rhk6ch91z05g6m1kj6z19qdvm9sck8v3xf73anpbfgr3m";
        };
      };
    };
    "phpactor/worse-reference-finder-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-worse-reference-finder-extension-6cf8dbec6fdcd2c6fe965ad1ceccae93d7e1adb3";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/worse-reference-finder-extension/zipball/6cf8dbec6fdcd2c6fe965ad1ceccae93d7e1adb3;
          sha256 = "1nyqagjyixy48lyg6b80lsvgd4lf0p8p8h6lzr7hifwqmkk814a5";
        };
      };
    };
    "phpactor/worse-reference-finders" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-worse-reference-finders-78bd0209b34dccbe84ce1e238390cf0f5b86da15";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/worse-reference-finder/zipball/78bd0209b34dccbe84ce1e238390cf0f5b86da15;
          sha256 = "1b735zmfsvbxxkbz4322j6ali0bccv4y22fsngba6szay3j1q2ry";
        };
      };
    };
    "phpactor/worse-reflection" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-worse-reflection-bbf17bde145b3a9c5e25dc51bfe0b94fe431ef39";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/worse-reflection/zipball/bbf17bde145b3a9c5e25dc51bfe0b94fe431ef39;
          sha256 = "0r2kgxjjq1p38j01dqrm35y354s8wxal9w3wkf9r5f00grndz9iy";
        };
      };
    };
    "phpactor/worse-reflection-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpactor-worse-reflection-extension-f050c7a070f0bb642093ba52ca699daeb187be9b";
        src = fetchurl {
          url = https://api.github.com/repos/phpactor/worse-reflection-extension/zipball/f050c7a070f0bb642093ba52ca699daeb187be9b;
          sha256 = "0y205ji6ws078slmicvlcv452q3z8vhl5gzj61xsrrzk2akmfdcf";
        };
      };
    };
    "phpbench/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpbench-container-c0e3cbf1cd8f867c70b029cb6d1b0b39fe6d409d";
        src = fetchurl {
          url = https://api.github.com/repos/phpbench/container/zipball/c0e3cbf1cd8f867c70b029cb6d1b0b39fe6d409d;
          sha256 = "1818l10w9wr4z780hy1ml9imlf8xagvbd8fyhi9kgm1pniqgpny2";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-b7ce3b176482dbbc1245ebf52b181af44c2cf55f";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/container/zipball/b7ce3b176482dbbc1245ebf52b181af44c2cf55f;
          sha256 = "0rkz64vgwb0gfi09klvgay4qnw993l1dc03vyip7d7m2zxi6cy4j";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-446d54b4cb6bf489fc9d75f55843658e6f25d801";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/log/zipball/446d54b4cb6bf489fc9d75f55843658e6f25d801;
          sha256 = "04baykaig5nmxsrwmzmcwbs60ixilcx1n0r9wdcnvxnnj64cf2kr";
        };
      };
    };
    "sebastian/diff" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-diff-720fcc7e9b5cf384ea68d9d930d480907a0c1a29";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/diff/zipball/720fcc7e9b5cf384ea68d9d930d480907a0c1a29;
          sha256 = "0i81kz91grz5vzifw114kg6dcfh150019zid7j99j2y5w7s1fqq2";
        };
      };
    };
    "seld/jsonlint" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "seld-jsonlint-e2e5d290e4d2a4f0eb449f510071392e00e10d19";
        src = fetchurl {
          url = https://api.github.com/repos/Seldaek/jsonlint/zipball/e2e5d290e4d2a4f0eb449f510071392e00e10d19;
          sha256 = "10y2d9fjmhnvr9sclmc1phkasplg0iczvj7d2y6i3x3jinb9sgnb";
        };
      };
    };
    "seld/phar-utils" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "seld-phar-utils-8800503d56b9867d43d9c303b9cbcc26016e82f0";
        src = fetchurl {
          url = https://api.github.com/repos/Seldaek/phar-utils/zipball/8800503d56b9867d43d9c303b9cbcc26016e82f0;
          sha256 = "1y7dqszq0rg07s1m7sg56dbqm1l61pfrrlh4mibm97xl4qfjxqza";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-f512001679f37e6a042b51897ed24a2f05eba656";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/console/zipball/f512001679f37e6a042b51897ed24a2f05eba656;
          sha256 = "1h1s4j4znmcgqs2wpfk9aspca1s1d25dhkzj0zmvvlrzbxh2jd1h";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-0a0d3b4bda11aa3a0464531c40e681e184e75628";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/filesystem/zipball/0a0d3b4bda11aa3a0464531c40e681e184e75628;
          sha256 = "0ifha65a2mrg4hp8r3q0wavyarx5yh39bk17a9lhq2i03jqx93vm";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-3a50be43515590faf812fbd7708200aabc327ec3";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/finder/zipball/3a50be43515590faf812fbd7708200aabc327ec3;
          sha256 = "1f0pbwkccyp43l13lf6nma8ldzabf356yin6fn9ab4061i4dx1d3";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-fbdeaec0df06cf3d51c93de80c7eb76e271f5a38";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-ctype/zipball/fbdeaec0df06cf3d51c93de80c7eb76e271f5a38;
          sha256 = "0ni2ldyfzdvchi4prlqyy5gr833z5mnnhm65l331jsdvzk2m53hk";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-34094cfa9abe1f0f14f48f490772db7a775559f2";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-mbstring/zipball/34094cfa9abe1f0f14f48f490772db7a775559f2;
          sha256 = "1lnrmk1yrv9cbs7kb2cwfgqzq1hwl135bhbkr6yyayfk67zs3rqa";
        };
      };
    };
    "symfony/polyfill-php73" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php73-5e66a0fa1070bf46bec4bea7962d285108edd675";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php73/zipball/5e66a0fa1070bf46bec4bea7962d285108edd675;
          sha256 = "05892z9cwfa7w8l6dc5xbvh7qp0mbyl25ixaz2xdm7yhi3rglymd";
        };
      };
    };
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-f5697ab4cb14a5deed7473819e63141bf5352c36";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/process/zipball/f5697ab4cb14a5deed7473819e63141bf5352c36;
          sha256 = "0xsix40pnp8rial7dhvnncayk80g2943dvfml171jdps1zxnxr2p";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-144c5e51266b281231e947b51223ba14acf1a749";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/service-contracts/zipball/144c5e51266b281231e947b51223ba14acf1a749;
          sha256 = "0k76dm3f61w1r5pdjd8a7gb0pckw0z7d965vsya0vbyhywj7l8qg";
        };
      };
    };
    "symfony/yaml" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-yaml-aa46bc2233097d5212332c907f9911533acfbf80";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/yaml/zipball/aa46bc2233097d5212332c907f9911533acfbf80;
          sha256 = "1m5s2czkjixbrfn6gbwnhnx4mgp4j3xppn6d0yj55mb7ljb4wr4s";
        };
      };
    };
    "twig/twig" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "twig-twig-18772e0190734944277ee97a02a9a6c6555fcd94";
        src = fetchurl {
          url = https://api.github.com/repos/twigphp/Twig/zipball/18772e0190734944277ee97a02a9a6c6555fcd94;
          sha256 = "05i3h7bklzyrfb9bfhilx4a1m1m85c6hnzq2f9wgnmwbk1i1fa81";
        };
      };
    };
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-aed98a490f9a8f78468232db345ab9cf606cf598";
        src = fetchurl {
          url = https://api.github.com/repos/webmozart/assert/zipball/aed98a490f9a8f78468232db345ab9cf606cf598;
          sha256 = "00w4s4z7vlsyvx3ii7374vgq705a3yi4maw3haa05906srn3d1ik";
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
  name = "phpactor";
  src = ./.;
  executable = true;
  symlinkDependencies = false;
  meta = {};
}