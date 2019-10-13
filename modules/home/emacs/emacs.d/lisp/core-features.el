;;; -*- lexical-binding: t; -*-

(eval-when-compile
  (require 'use-package))

(defvar blox-helm-enable nil)
(defvar blox-boon-enable nil)
(defvar blox-xah-fly-keys-enable nil)
(defvar blox-lsp-enable nil)
(defvar blox-evil-enable nil)

(add-to-list 'load-path (concat (file-name-directory load-file-name) "features/"))
(when blox-mu4e-enable
  (add-to-list 'load-path blox-mu4e-path))

(eval-when-compile
  (when blox-helm-enable
    (require 'feat-helm))
  (when blox-boon-enable
    (require 'feat-boon)))

(use-package xah-fly-keys
  :if blox-xah-fly-keys-enable
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))

(use-package general
  :if blox-evil-enable
  :config
  (general-create-definer blox-leader-def
                          :keymaps 'normal
                          :prefix "SPC")
  (blox-leader-def
   "b" '(:ignore t :which-key "buffers")
   "b b" 'helm-buffers-list
   ;;   "b k" '-kill-this-buffer
   "f" '(:ignore t :which-key "files")
   "f f" 'helm-find-files
   "g" '(:ignore t :which-key "git")
   "g g" 'magit-status
   "h" '(:ignore t :which-key "help")
   "h b" 'helm-descbinds
   "p" '(:ignore t which-key "projectile")
   "p f" 'helm-projectile-find-file
   "w" '(:ignore t :which-key "windows")
   "w k" 'delete-window)
  (general-create-definer blox-local-leader-def
                          :prefix "SPC m"))

(use-package evil
  :hook (after-init . evil-mode)
  :if blox-evil-enable
  :init
  (setq evil-want-keybinding nil
        evil-collection-company-use-tng nil
        evil-want-fine-undo t))

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(use-package evil-collection
  :if blox-evil-enable
  :after evil
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

;;; --- Extra UI features

(use-package treemacs
  :defer t
  :after doom-themes
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (require 'doom-themes-ext-treemacs)
  (doom-themes-treemacs-config)
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-git-command-pipe           ""
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-max-git-entries            5000
          treemacs-no-png-images              nil
          treemacs-no-delete-other-windows    t
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name "treemacs-persist" blox-cache-dir)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-cursor                nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :if blox-evil-enable
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)

(use-package treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :disabled
  :after treemacs magit)

(use-package gitconfig-mode
  :mode ("/\\.gitconfig\\'"      "/\\.git/config\\'"
         "/modules/.*/config\\'" "/git/config\\'"
         "/\\.gitmodules\\'"     "/etc/gitconfig\\'"))
(use-package gitignore-mode
  :mode ("/\\.gitignore\\'"  "gitignore_global\\'"
         "/info/exclude\\'" "/git/ignore\\'"))

(use-package git-commit
  ;; Highlight issue ids in commit messages and spellcheck
  :hook (git-commit-setup . git-commit-turn-on-flyspell)
  :init
  ;; Mark a few major modes as safe
  (put 'git-commit-major-mode 'safe-local-variable
       (lambda (m) (or (eq m 'gfm-mode)
                       (eq m 'text-mode)
                       (eq m 'git-commit-elisp-text-mode))))
  :config (setq git-commit-major-mode 'gfm-mode))

(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  ;; Always show recent/unpushed/unpulled commits
  (setq magit-section-initial-visibility-alist '((unpushed . show)
                                                 (unpulled . show)))
  ;; Always highlight word differences in diff
  (setq magit-diff-refine-hunk 'all)

  ;; Don't change my window layout after quitting magit
  ;; Ofter I invoke magit and then do a lot of things in other windows
  ;; On quitting, magit would then "restore" the window layout like it was
  ;; when I first invoked magit. Don't do that!
  (setq magit-bury-buffer-function 'magit-mode-quit-window)

  ;; Show magit status in the same window
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;; --- Development integration

(use-package prog-mode
  :ensure nil
  :hook (prog-mode . (lambda ()
                       (setq-local comment-auto-fill-only-comments t)
                       (setq-local fill-column 70))))

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (use-package company-quickhelp
    :config (company-quickhelp-mode 1)))

(use-package flycheck
  :init
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  :hook (prog-mode . flycheck-mode))

(use-package eldoc
  :ensure nil
  :hook ((prog-mode . eldoc-mode)
         (org-mode . eldoc-mode)))

(when blox-lsp-enable
  (require 'feat-lsp))

(use-package lua-mode
  :if blox-lua-enable
  :mode "\\.lua$"
  :interpreter "lua"
  :config
  (setq lua-indent-level 4)
  (setq lua-indent-string-contents t)
  (setq lua-prefix-key nil))

(use-package highlight-indent-guides
  :hook (python-mode . highlight-indent-guides-mode)
  :config
  ;; Don't highlight first level (that would be a line at column 1)
  (defun my-highlighter (level responsive display)
    (unless (> 1 level) ; replace `1' with the number of guides you want to hide
      (highlight-indent-guides--highlighter-default level responsive display)))

  (setq highlight-indent-guides-highlighter-function 'my-highlighter)
  (setq highlight-indent-guides-method 'character))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company-lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package org
  :hook (org-mode . (lambda ()
                      (variable-pitch-mode 1)
                      (linum-mode 0)))
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link))
  :custom
  ;;(org-hide-leading-stars t "Cleaner view")
  (org-startup-indented t)
  (org-ellipsis " ∨ ")
  (org-pretty-entities t)
  (org-hide-emphasis-markers t)
  (org-fontify-whole-heading-line t)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-startup-folded nil "when opening a org file, don't collapse headings")
  (org-startup-truncated nil "wrap long lines. don't let it disappear to the right")
  (org-return-follows-link "when in a url link, enter key should open it")
  :custom-face (variable-pitch ((nil :family "iA Writer Duospace")))
  :config
  (setq calendar-week-start-day 1)
  (use-package org-agenda
    :ensure nil
    :config
    (setq org-agenda-window-setup 'current-window))
  (use-package org-bullets
    :commands org-bullets-mode
    :custom
    (inhibit-compacting-font-caches t "Performance improvements")
    :hook (org-mode . org-bullets-mode))
  (use-package org-caldav))

(use-package olivetti
  :commands olivetti-mode
  :hook ((org-mode org-agenda-mode) . olivetti-mode))

(use-package dired
  :ensure nil
  :init
  (setq dired-listing-switches "-hal --group-directories-first --time-style=long-iso"))

;; Display the recursive size of directories in Dired
(use-package dired-du
  :after dired
  :commands dired-du-mode
  :config
  ;; human readable size format
  (setq dired-du-size-format t))

(use-package async)
(use-package dired-async  ; Part of async
  :after dired
  :ensure nil
  :config (dired-async-mode 1))
;; from doom-emacs
(use-package dired-k
  :after dired
  :init
  (setq-default dired-k-human-readable t)
  (setq-default dired-k-padding 1)

  (defun +dired*dired-k-highlight (orig-fn &rest args)
    "Butt out if the requested directory is remote (i.e. through tramp)."
    (unless (file-remote-p default-directory)
      (apply orig-fn args)))
  (advice-add #'dired-k--highlight :around #'+dired*dired-k-highlight)

  (add-hook 'dired-initial-position-hook #'dired-k)
  (add-hook 'dired-after-readin-hook #'dired-k-no-revert))

(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :hook (pdf-view-mode . pdf-view-init))

(use-package epa-file
  :ensure nil
  :init
  (add-hook 'after-init-hook 'epa-file-enable))

(use-package mu4e
  :ensure nil
  :custom (epg-gpg-program  blox-gpg-binary)
  :config
  (setq-default mu4e-index-update-in-background t
                mu4e-update-interval 150
                mu4e-headers-auto-update t
                mu4e-view-show-addresses t
                mu4e-headers-include-related t
                mu4e-headers-skip-duplicates t
                mu4e-compose-dont-reply-to-self t
                ;; thread prefix marks
                mu4e-headers-has-child-prefix '("."  . "◼ ")
                mu4e-headers-default-prefix '(" "  . "│ ")
                mu4e-context-policy 'pick-first
                mu4e-compose-context-policy 'ask
                mu4e-msg2pdf blox-mu-msg2pdf-binary
                mu4e-mu-binary blox-mu-binary
                mu4e-sent-messages-behavior 'delete
                mu4e-use-fancy-chars t
                mu4e-view-show-images t
                mu4e-change-filenames-when-moving t)
  (use-package evil-mu4e)
  (use-package mu4e-maildirs-extension)
  (mu4e-maildirs-extension))

(use-package calfw
  :config
  (use-package calfw-ical)
  (use-package calfw-org))

(use-package session
  :config
  (add-hook 'after-init-hook 'session-initialize))

(provide 'core-features)
