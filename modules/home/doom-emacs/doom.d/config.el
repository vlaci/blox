;;; /nix/store/0s16xdxx9xwcm0g8w7zzxp7p3rnwmwsq-straight-emacs-env/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-theme 'doom-nord
      lsp-keymap-prefix "s-a")

(after! ivy-posframe
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))))
