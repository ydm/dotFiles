;; -*- lexical-binding: t -*-

;; Language modes
(use-package haskell-mode :ensure t)
(use-package markdown-mode :ensure t)   ; Also improves eldoc.
(use-package meson-mode :ensure t)
(use-package pkgbuild-mode :ensure t)
(use-package solidity-mode :ensure t)
(use-package yaml-mode :ensure t)
;; TODO: dockerfile-ts-mode
;; TODO: json-ts-mode

(use-package eldoc-box
  :init (add-hook 'eldoc-mode-hook #'eldoc-box-hover-mode)
  :load-path "~/dev/emacs/eldoc-box"
  :custom ((eldoc-box-minor-mode-string " eb")
           (eldoc-box-offset '(16 24 16)))
  :custom-face (eldoc-box-border ((t (:background "#454545")))))

(use-package vterm
  :custom (vterm-max-scrollback 16384)
  :ensure t)

;; TODO: popwin + (popwin-mode t)
;; TODO: projectile
;; TODO: yasnippet-snippets + (yas-global-mode t)

(provide 'd-packages)
