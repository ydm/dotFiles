;; -*- lexical-binding: t -*-

;; Install additional language modes.
(use-package cmake-mode :ensure t)
(use-package csv-mode :ensure t)
(use-package haskell-mode :ensure t)
(use-package markdown-mode :ensure t) ; Also an optional dependency of eldoc-box.
(use-package meson-mode :ensure t)
(use-package pkgbuild-mode :ensure t)
(use-package solidity-mode :ensure t)
(use-package yaml-mode :ensure t)

(use-package eldoc-box
  :init (add-hook 'eldoc-mode-hook #'eldoc-box-hover-mode)
  :custom ((eldoc-box-clear-with-C-g t)
           (eldoc-box-lighter " eb")
           (eldoc-box-offset '(16 24 16)))
  :custom-face (eldoc-box-border ((t (:background "#454545"))))
  :ensure t)

(use-package vterm
  :custom (vterm-max-scrollback 16384)
  :ensure t)

;; Use local packages files.
(use-package eglot-hierarchy :load-path "~/dotFiles/emacs/libraries")

;; TODO: popwin + (popwin-mode t)
;; TODO: projectile
;; TODO: yasnippet-snippets + (yas-global-mode t)

(provide 'd-packages)
