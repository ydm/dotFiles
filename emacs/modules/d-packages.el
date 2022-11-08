;; -*- lexical-binding: t; -*-

(d:module
 '((packages cmake-mode
             dockerfile-mode
             go-mode
             haskell-mode
             json-mode
             markdown-preview-mode
             meson-mode
             nix-mode
             pkgbuild-mode
             solidity-mode
             yaml-mode

             ;; Needed by library/interactives.el
             projectile
             )))

(provide 'd-packages)
