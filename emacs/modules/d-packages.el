;; -*- lexical-binding: t -*-

(use-package ace-jump-mode :ensure t)
(use-package ace-window :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package haskell-mode :ensure t)
(use-package json-mode :ensure t)
(use-package meson-mode :ensure t)
(use-package pkgbuild-mode :ensure t)
(use-package solidity-mode :ensure t)
(use-package typescript-mode :ensure t)
(use-package yaml-mode :ensure t)

(use-package vterm
  :commands vterm-toggle
  :custom (vterm-max-scrollback 16384)
  :ensure t)
(use-package vterm-toggle :ensure t)

;; popwin && '(popwin-mode t)
;; yasnippet-snippets && '(yas-global-mode t)
;; projectile

(provide 'd-packages)
