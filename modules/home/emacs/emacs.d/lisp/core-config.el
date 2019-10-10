;;; -*- lexical-binding: t; -*-

(setq-default
 custom-safe-themes t
 ;; Bookmarks
 bookmark-default-file (concat blox-etc-dir "bookmarks")
 bookmark-save-flag t
 ;; Recent files
 org-agenda-files nil
 recentf-exclude (append (list blox-local-dir) (mapcar #'file-truename org-agenda-files))
 recentf-save-file (concat blox-local-dir "recentf")
 ;; Formatting
 delete-trailing-lines nil
 fill-column 80
 sentence-end-double-space nil
 word-wrap t
 ;; Scrolling
 hscroll-margin 1
 hscroll-step 1
 scroll-conservatively 1001
 scroll-margin 0
 scroll-preserve-screen-position t
 ;; Whitespace
 indent-tabs-mode nil
 require-final-newline t
 tab-always-indent t
 tab-width 4
 ;; Wrapping
 truncate-lines t
 truncate-partial-width-windows 50)

(defalias 'yes-or-no-p 'y-or-n-p)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(eval-when-compile
  (require 'use-package)
  (defun use-package-normalize/:theme (_name _keyword _args))

  (defun use-package-handler/:theme (name _keyword _arg rest state)
    (let ((body (use-package-process-keywords name rest state)))
      (use-package-concat
       body
       (unless noninteractive
         `((add-to-list 'custom-theme-load-path
                        (file-name-directory
                         (locate-library ,(symbol-name name)))))))))

  (add-to-list 'use-package-defaults
               '(:no-require t (lambda (name args)
                                 (plist-member args :theme))))

  (add-to-list 'use-package-keywords
               :theme))

;; builtin packages

(use-package bind-key
  :demand)

(use-package savehist
  :ensure nil
  :unless noninteractive
  :defer 1
  :config
  (setq savehist-file (concat blox-cache-dir "savehist")
        savehist-save-minibuffer-history t
        savehist-autosave-interval nil ; save on kill only
        savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
  (savehist-mode 1))

(use-package saveplace
  :ensure nil
  :unless noninteractive
  :config
  (setq save-place-file (concat blox-cache-dir "saveplace"))
  (save-place-mode))

(use-package recentf
  :ensure nil
  :unless noninteractive
  :config
  (setq recentf-max-menu-items 25
        recentf-max-saved-items 1000)
  (recentf-mode 1)
  (run-at-time nil (* 2 60)  (lambda ()
                               (let ((save-silently t))
                                 (recentf-save-list)))))

(use-package whitespace
  :ensure nil
  :init
  (setq-default
   whitespace-style
   (quote
    (face
     trailing
     tabs
     ;;spaces
     lines-tail
     ;;newline
     empty
     space-after-tab
     space-before-tab
     ;;space-mark
     ;;tab-mark
     ;;newline-mark
     )))
  :hook (prog-mode . whitespace-mode))

(use-package paren
  :ensure nil
  :hook (prog-mode . show-paren-mode))

(use-package delsel
  :ensure nil
  :hook ((text-mode prog-mode) . delete-selection-mode))

(use-package electric
  :ensure nil
  :hook ((prog-mode . electric-quote-local-mode)
         (text-mode . electric-quote-local-mode)
         (org-mode . electric-quote-local-mode)
         (message-mode . electric-quote-local-mode)
         (prog-mode . electric-indent-local-mode)
         (prog-mode . electric-layout-mode)
         (haskell-mode . (lambda () (electric-indent-local-mode -1)))
         (nix-mode . (lambda () (electric-indent-local-mode -1)))))

;; always installed packages

(use-package alert :defer t
  :config
  ;; send alerts by default to D-Bus
  (setq alert-default-style 'notifications))

(use-package diff-hl
  :hook (((prog-mode text-mode vc-dir-mode) . turn-on-diff-hl-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (use-package diff-hl-dired  ;; in diff-hl package
    :ensure nil
    :after dired
    :hook (dired-mode . diff-hl-dired-mode))
  (setq diff-hl-draw-borders t))

(fringe-mode '(3 . 1))

(use-package dimmer
  :unless noninteractive
  :defer 10
  :config
  (setq dimmer-fraction 0.25)
  ;;(setq dimmer-use-colorspace ':rgb)
  (dimmer-mode))

(use-package beacon
  :defer 5
  :config (beacon-mode 1))

(use-package fancy-narrow
  :bind (("C-x n" . fancy-narrow-or-widen-dwim)
         ("C-x N" . narrow-or-widen-dwim))
  :config
    ;;; toggle narrow or widen (region or defun) with C-x n
  (defun fancy-narrow-or-widen-dwim (p)
    "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first.  Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (fancy-narrow-active-p) (not p)) (fancy-widen))
          ((region-active-p)
           (fancy-narrow-to-region (region-beginning)
                                   (region-end)))
          ((derived-mode-p 'org-mode)
           ;; `org-edit-src-code' is not a real narrowing
           ;; command. Remove this first conditional if
           ;; you don't want it.
           (cond ((ignore-errors (org-edit-src-code) t))
                 ((ignore-errors (org-fancy-narrow-to-block) t))
                 (t (org-narrow-to-subtree))))
          ((derived-mode-p 'latex-mode)
           (LaTeX-narrow-to-environment))
          (t (fancy-narrow-to-defun))))

  (defun narrow-or-widen-dwim (p)
    "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first.  Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (buffer-narrowed-p) (not p)) (widen))
          ((region-active-p)
           (narrow-to-region (region-beginning)
                             (region-end)))
          ((derived-mode-p 'org-mode)
           ;; `org-edit-src-code' is not a real narrowing
           ;; command. Remove this first conditional if
           ;; you don't want it.
           (cond ((ignore-errors (org-edit-src-code) t))
                 ((ignore-errors (org-narrow-to-block) t))
                 (t (org-narrow-to-subtree))))
          ((derived-mode-p 'latex-mode)
           (LaTeX-narrow-to-environment))
          (t (narrow-to-defun)))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package volatile-highlights
  :hook ((text-mode . volatile-highlights-mode)
         (prog-mode . volatile-highlights-mode)))

(use-package projectile
  :config
  (setq projectile-require-project-root nil)
  (projectile-mode))

(use-package aggressive-indent
  :hook
  ((emacs-lisp-mode
    lisp-mode hy-mode
    clojure-mode
    css
    js2-mode) . aggressive-indent-mode))

(use-package which-key
  :demand
  :commands which-key-mode
  :config (which-key-mode 1))

(use-package kaolin-themes :theme)
(use-package ample-theme :theme)
(use-package color-theme-sanityinc-tomorrow :theme)
(use-package poet-theme
  :theme
  :custom-face (mode-line ((nil (:overline nil)))))
(use-package moe-theme :theme)
(use-package solarized-theme :theme
  :config
  (setq x-underline-at-descent-line t))
(use-package leuven-theme :theme)
(use-package apropospriate-theme :theme)
(use-package doom-themes)

(defcustom blox-default-theme 'solarized-light
  "Default theme to use"
  :type (append '(radio symbol) (mapcar (lambda (th) (list 'const th)) (custom-available-themes)))
  :group 'blox)

(add-hook 'after-init-hook (lambda ()
                             (unless noninteractive (load-theme blox-default-theme t))))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-minor-modes t
        doom-modeline-version nil))

(use-package minions
  :unless noninteractive
  :config
  (setq minions-mode-line-lighter " 𝌆 ")
  (setq minions-direct '(projectile-mode flycheck-mode multiple-cursors-mode sticky-buffer-mode))
  (minions-mode))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package flyspell
  :ensure nil
  :hook ((prog-mode . flyspell-prog-mode)
         (text-mode . flyspell-mode))
  :init (setq-default flyspell-issue-message-flag nil)
  :config
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic ispell-dictionary)
  (use-package flyspell-correct-popup
    :bind (:map flyspell-mode-map
                ("C-;" . flyspell-correct-word-generic))))

(provide 'core-config)
