;;; -*- lexical-binding: t; -*-

(use-package boon
  :config
  (use-package avy
    :config
    (setq avy-background t)
    (setq avy-style 'at-full)
    (setq avy-timeout-seconds 0.3))

  (use-package doom-modeline
    :defer
    :config
    (doom-modeline-def-segment boon-state
      "The current boon state."
      (when (bound-and-true-p boon-mode)
        (propertize (concat " <" (boon-state-string) "> ")
                    'face (if (doom-modeline--active)
                              (cond (boon-command-state 'doom-modeline-evil-normal-state)
                                    (boon-insert-state  'doom-modeline-evil-insert-state)
                                    (boon-special-state 'doom-modeline-evil-motion-state)
                                    (t                  'doom-modeline-evil-emacs-state))))))
    (doom-modeline-def-modeline 'boon-line
      '(bar workspace-number window-number boon-state matches buffer-info remote-host buffer-position selection-info)
      '(misc-info persp-name lsp github debug minor-modes input-method buffer-encoding major-mode process vcs checker))
    (advice-add 'doom-modeline-set-main-modeline
                :override (lambda (&optional default)
                            (doom-modeline-set-modeline 'boon-line default))))

  (require 'boon-qwerty)
  (boon-mode))

(provide 'feat-boon)
