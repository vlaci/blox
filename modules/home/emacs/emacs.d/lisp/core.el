;;; -*- lexical-binding: t; -*-

(add-to-list 'load-path (file-name-directory load-file-name))

(defun conf-initialize ()
  (setq package-enable-at-startup nil
        package--init-file-ensured t
        custom-file (expand-file-name "custom-settings.el" user-emacs-directory))

  (load "nix-integration" t)
  (load custom-file t)

  (setq initial-scratch-message nil)
  (setq-default inhibit-startup-screen t)

  (defvar user-temporary-file-directory
    (concat
     (file-name-as-directory (or (getenv "XDG_RUNTIME_DIR") temporary-file-directory))
     (file-name-as-directory (concat "emacs-tmp." user-login-name))))

  (make-directory user-temporary-file-directory t)

  (setq backup-directory-alist
        `((".*" . ,user-temporary-file-directory)
          (,tramp-file-name-regexp nil)))

  (setq make-backup-files t               ; backup of a file the first time it is saved.
        backup-by-copying t               ; don't clobber symlinks
        version-control t                 ; version numbers for backup files
        delete-old-versions t             ; delete excess backup files silently
        kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
        kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
        create-lockfiles nil)

  (setq auto-save-list-file-prefix
        (concat user-temporary-file-directory ".auto-saves-"))

  (setq auto-save-file-name-transforms
        `((".*" ,user-temporary-file-directory t)))
  (eval-when-compile
    (require 'use-package))

  (require 'core-ui)
  (require 'core-config)
  (require 'core-features)
  (message "Loading Emacs...done (%.3fs)"
           (float-time (time-subtract (current-time) blox-before-user-init-time))))

(conf-initialize)

(provide 'core)
