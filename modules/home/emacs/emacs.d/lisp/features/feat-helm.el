;;; -*- lexical-binding: t; -*-

(use-package helm
  :commands (helm-M-x
             helm-mini
             helm-imenu
             helm-resume
             helm-execute-persistent-action
             helm-select-action)
  :defer 2
  :bind (("M-x"     . helm-M-x)
         ("<f1>" . helm-mini)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)  ; Rebind tab to run persistent action
         ("C-i"   . helm-execute-persistent-action)  ; Make TAB work in terminals
         ("C-z"   . helm-select-action)  ; List actions
         ("M-y"   . helm-show-kill-ring)
         )
  :config
  (use-package helm-ag
    :commands (helm-ag
               helm-ag-this-file
               helm-do-ag
               helm-do-ag-this-file
               helm-do-ag-project-root))

  (use-package helm-descbinds
    :bind (("C-h b" . helm-descbinds)))

  (use-package helm-projectile
    :after projectile
    :bind (("C-c C-p f" . helm-projectile-find-file))
    :config (helm-projectile-on))

  ;; helm "hacks" like better path expandsion
  (use-package helm-ext
    :config
    ;; Skip . and .. for non empty dirs
    (helm-ext-ff-enable-skipping-dots t)

    ;; Enable zsh/fish shell like path expansion
    (helm-ext-ff-enable-zsh-path-expansion t)
    (helm-ext-ff-enable-auto-path-expansion t)

    ;; Don't use minibuffer if there's something there already
    (helm-ext-minibuffer-enable-header-line-maybe t))
  (use-package helm-make
    :commands (helm-make helm-make-projectile))

  (use-package helm-backup
    :commands (helm-backup-versioning helm-backup)
    :hook (after-save . helm-backup-versioning))

  ;; use swiper with helm backend for search
  (use-package swiper-helm
    :bind ("\C-s" . swiper-helm))

  (use-package helm-themes)
  ;; See https://github.com/bbatsov/prelude/pull/670 for a detailed
  ;; discussion of these options.
  (setq helm-split-window-inside-p            t
        helm-buffers-fuzzy-matching           t
        helm-recentf-fuzzy-match              t
        helm-M-x-fuzzy-match                  t
        helm-move-to-line-cycle-in-source     t
        helm-ff-search-library-in-sexp        t
        helm-ff-file-name-history-use-recentf t
        helm-echo-input-in-header-line        t)

  (setq helm-net-prefer-curl t)

  ;; keep follow-mode in between helm sessions once activated
  (setq helm-follow-mode-persistent t)

  ;; Smaller helm window
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 30)
  (helm-autoresize-mode 1)

  (defun spacemacs//helm-hide-minibuffer-maybe ()
    "Hide minibuffer in Helm session if we use the header line as input field."
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))

  (add-hook 'helm-minibuffer-set-up-hook
            'spacemacs//helm-hide-minibuffer-maybe)

  ;; Don't show details in helm-mini for tramp buffers
  (setq helm-buffer-skip-remote-checking t)

  (require 'helm-bookmark)
  ;; Show bookmarks (and create bookmarks) in helm-mini
  (setq helm-mini-default-sources '(helm-source-buffers-list
                                    helm-source-recentf
                                    helm-source-bookmarks
                                    helm-source-bookmark-set
                                    helm-source-buffer-not-found))

  (substitute-key-definition 'find-tag 'helm-etags-select global-map)
  (setq projectile-completion-system 'helm)
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-boring-buffer-regexp-list
        (append helm-boring-buffer-regexp-list
                '("\\`\\*Messages"
                  "\\`\\*Compile"
                  "\\`\\*Pp Eval"))))

(use-package helm
  :if blox-boon-enable
  :after boon
  :bind (:map boon-x-map
              ("x" . helm-M-x)
              ("b" . helm-mini)))

(use-package helm
  :if blox-xah-fly-keys-enable
  :after xah-fly-keys
  :bind (:map xah-fly-leader-key-map
              ("f" . helm-mini)))

(provide 'feat-helm)
