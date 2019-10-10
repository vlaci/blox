;;; -*- lexical-binding: t; -*-

(defvar blox-php-lsp-command '("php", "php-language-server"))
(defvar blox-python-lsp-command '("pyls"))
(defvar blox-rust-lsp-command '("rls"))

(use-package auto-virtualenv)
(use-package pyvenv
  :commands pyvenv-mode)

(use-package php-mode
  :mode "\\.php\\'"
  :commands php-mode)

(use-package rust-mode
  :mode "\\.rs\\'"
  :commands rust-mode)

(use-package lsp-mode
  :config
  (setq lsp-prefer-flymake nil))

(use-package lsp-mode
  :if blox-c-enable
  :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (lsp)))
  :config
  (use-package ccls
    :custom
    (ccls-executable blox-c-lsp-executable)))

(use-package lsp-mode
  :if blox-python-enable
  :hook (python-mode . (lambda ()
                         (require 'auto-virtualenv)
                         (auto-virtualenv-set-virtualenv)
                         (pyvenv-mode t)
                         (lsp)))
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection blox-python-lsp-command)
                    :major-modes '(python-mode)
                    :server-id 'pyls-nix))

  :custom
  (lsp-clients-python-command blox-python-lsp-command))

(use-package lsp-mode
  :if blox-php-enable
  :hook (php-mode . lsp)
  :custom
  (lsp-clients-php-server-command blox-php-lsp-command))

(use-package lsp-mode
  :if blox-rust-enable
  :hook (rust-mode . lsp)
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection blox-rust-lsp-command)
                    :major-modes '(rust-mode rustic-mode)
                    :server-id 'rls-nix
                    :notification-handlers (lsp-ht ("window/progress" 'lsp-clients--rust-window-progress)))))


(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company-lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

(provide 'feat-lsp)
