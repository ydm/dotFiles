;; -*- lexical-binding: t -*-

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(python-ts-mode . ("pyright-langserver" "--stdio"))))

(use-package python
  :init
  (add-hook 'python-mode-hook    #'python-ts-mode)
  (add-hook 'python-ts-mode-hook #'eglot-ensure)
  :ensure t)

(provide 'd-python)
