;; -*- lexical-binding: t -*-

(use-package go-mode
  :init (add-hook 'go-mode-hook #'eglot-ensure)
  :ensure t)

(provide 'd-go)

