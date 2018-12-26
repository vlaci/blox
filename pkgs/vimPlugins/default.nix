{ pkgs }:

with pkgs;

{
  tender = vimUtils.buildVimPlugin {
    name = "tender.vim";
    src = pkgs.fetchFromGitHub {
      owner = "jacoborus";
      repo = "tender.vim";
      rev = "6b0497a59233b3e67fb528a498069eb1d24743f9";
      sha256 = "1iqijk7xq0g6p3j8jgzgrhqizw87fnfryx73iaqqx5iyq1k8i9mn";
    };
  };

  ncm2 = vimUtils.buildVimPlugin {
    name = "ncm2";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2";
      rev = "f962aa074a3bf4e7526beca21442e03987829d43";
      sha256 = "1swca2iyfwn90h3advgzb5ipwqpxg8r4r0qc7ryik2k2awapnjgf";
    };
  };

  yarp = vimUtils.buildVimPlugin {
    name = "nvim-yarp";
    src = fetchFromGitHub {
      owner = "roxma";
      repo = "nvim-yarp";
      rev = "52317ced0e16f226f0d44878917d0b5f4657b4d4";
      sha256 = "1xj1n9x1nxjbbpp29x5kkwr0bxziwzn8n2b8z9467hj9w646zyrj";
    };
  };

  emmet = vimUtils.buildVimPlugin {
    name = "emmet-vim";
    src = fetchFromGitHub {
      owner = "mattn";
      repo = "emmet-vim";
      rev = "63c98d801b2123cc0e88f622644770ca7d89e791";
      sha256 = "15d71yancgafgvy2858cd1f2k0vb2pl3yym5rzv7jgp052qyxvv0";
    };
    buildInputs = [ zip ];
  };

  which-key = vimUtils.buildVimPlugin {
    name = "vim-which-key";
    src = fetchFromGitHub {
      owner = "liuchengxu";
      repo = "vim-which-key";
      rev = "750f385337e9390ef2d17ce57179a875dc1563bd";
      sha256 = "1rnvdyghdwn24radfxn2jbg9jmgxkdfq15nf9kyzwq87zv2a0gr5";
    };
  };
}
