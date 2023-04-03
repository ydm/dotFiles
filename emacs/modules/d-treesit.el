;; -*- lexical-binding: t -*-

(require 'eglot)                        ; eglot-server-programs
(require 'treesit)

(add-to-list 'treesit-extra-load-path
             (expand-file-name "~/local/external/tree-sitter-module/dist"))

(use-package go-ts-mode
  :init (add-hook 'go-ts-mode-hook #'eglot-ensure)
  :ensure nil)

(use-package typescript-ts-mode
  :init (add-hook 'typescript-ts-mode-hook #'eglot-ensure)
  :ensure nil)

(provide 'd-treesit)
