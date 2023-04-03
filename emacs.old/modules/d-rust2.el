;; -*- lexical-binding: t; -*-

(d:module
 '((packages rust-mode))

 (add-hook 'rust-mode-hook    #'rust-ts-mode)
 (add-hook 'rust-ts-mode-hook #'eglot-ensure)

 ;; https://joaotavora.github.io/eglot/
 (let* ((path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer")
        (full (expand-file-name path))
        (key '(rust-ts-mode rust-mode)))
   (message "full=%s" full)
   (with-eval-after-load 'eglot
     (setq eglot-server-programs (assoc-delete-all key eglot-server-programs))
     (add-to-list 'eglot-server-programs (list key full)))))

(provide 'd-rust2)
