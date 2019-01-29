;;; -*- lexical-binding: t; -*-

(defvar blox-emacs-dir (file-truename user-emacs-directory)
  "The path to this emacs.d directory.")

(defvar blox-local-dir (concat blox-emacs-dir ".local/")
  "Root directory for local Emacs files. Use this as permanent storage for files
that are safe to share across systems (if this config is symlinked across
several computers).")

(defvar blox-etc-dir (concat blox-local-dir "etc/")
  "Directory for non-volatile storage.
Use this for files that don't change much, like servers binaries, external
dependencies or long-term shared data.")

(defvar blox-cache-dir (concat blox-local-dir "cache/")
  "Directory for volatile storage.
Use this for files that change often, like cache files.")

(defvar blox--config-in-site nil
  "Whether configuration is located in site-lisp")

(defvar blox-before-user-init-time (current-time)
  "Value of `current-time' when Emacs begins loading `user-init-file'.")

(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      file-name-handler-alist nil)

(defvar blox--file-name-handler-alist
  file-name-handler-alist)

(defun blox/finalize ()
  (setq gc-cons-threshold 16777216
        gc-cons-percentage 0.1
        file-name-handler-alist blox--file-name-handler-alist)
  (unless noninteractive
    (make-directory blox-local-dir t)
    (make-directory blox-etc-dir t)
    (make-directory blox-cache-dir t))
  t)

(add-hook 'emacs-startup-hook #'blox/finalize)

(setq blox--config-in-site (locate-library "lisp/core"))
(if blox--config-in-site
    (require 'core "lisp/core")
  (setq user-emacs-directory (file-name-directory load-file-name))
  (require 'core (concat user-emacs-directory "lisp/core")))
