;; -*- lexical-binding: t -*-

(use-package ace-jump-mode :ensure t)
(use-package ace-window :ensure t)
(use-package eldoc-box
  :init (add-hook 'eldoc-mode-hook #'eldoc-box-hover-mode)
  :custom (eldoc-box-offset '(16 24 16)))
(use-package haskell-mode :ensure t)
(use-package markdown-mode :ensure t)   ; Also improves eldoc.
(use-package meson-mode :ensure t)
(use-package pkgbuild-mode :ensure t)
(use-package solidity-mode :ensure t)
(use-package yaml-mode :ensure t)

(use-package vterm
  :custom (vterm-max-scrollback 16384)
  :ensure t)

;; TODO: Use dockerfile-ts-mode json-ts-mode

;; popwin && '(popwin-mode t)
;; yasnippet-snippets && '(yas-global-mode t)
;; projectile

(provide 'd-packages)
