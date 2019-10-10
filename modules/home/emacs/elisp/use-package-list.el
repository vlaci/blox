;;; -*- lexical-binding: t; -*-
;;; use-package-list.el --- List use-package declarations in config file

;; Copyright (C) 2017 Matthew Bauer
;; Copyright (C) 2019 László Vaskó

;; Author: Matthew Bauer <mjbauer95@gmail.com>

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; ‘ensure’ packages at compile time.

;;; Code:

(require 'json)
(require 'use-package)
(eval-when-compile
  (require 'cl))

(defun use-package-list (script)
  "Count use-package declarations listed in SCRIPT."

  (defvar use-package-list--is-running t)
  (let ((use-package-verbose nil)
        (use-package-always-ensure nil)
        (use-package-check-before-init t)
        (use-package-always-defer t)
        (use-package-list--packages nil)
        (use-package-ensure-function 'ignore))
    (advice-add 'use-package
                :before (lambda (name &rest args)
                          (let ((noninteractive nil))
                            (when (and
                                   (not (plist-get args :disabled))
                                   (not (eval (plist-get args :unless)))
                                   (or (not (member :if args))
                                       (eval (plist-get args :if)))
                                   (or (not (member :when args))
                                       (eval (plist-get args :when)))
                                   (or (not (member :ensure args))
                                       (plist-get args :ensure)))
                              (when (and (member :ensure args)
                                         (not (eq (plist-get args :ensure) t))
                                         (symbolp (plist-get args :ensure)))
                                (setq name (plist-get args :ensure)))
                              (add-to-list 'use-package-list--packages name)))))

    (advice-add 'use-package-handler/:defer
                :around (lambda (x name keyword arg rest state)
                          (let ((body (use-package-process-keywords name rest
                                        (plist-put state :deferred t)))
                                (name-string (use-package-as-string name)))
                            (dolist (command
                                     (delete-dups (plist-get state :commands)))
                              (fset command (lambda (&rest args))))
                            body)))
    (load script nil nil t)

    (princ (if (null use-package-list--packages)
               "[]"
             (json-encode use-package-list--packages)))

    use-package-list--packages))

(provide 'use-package-list)
;;; use-package-list.el ends here
