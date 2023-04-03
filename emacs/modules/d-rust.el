;; -*- lexical-binding: t -*-

(require 'eglot)                        ; eglot-server-programs

(let* ((path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer")
       (full (expand-file-name path))
       (akey '(rust-ts-mode rust-mode)))
  (setq eglot-server-programs (assoc-delete-all akey eglot-server-programs))
  (add-to-list 'eglot-server-programs (list akey full)))

(use-package rust-ts-mode
  :init (add-hook 'rust-ts-mode-hook #'eglot-ensure)
  :after d-treesit
  :ensure nil)

(provide 'd-rust)
