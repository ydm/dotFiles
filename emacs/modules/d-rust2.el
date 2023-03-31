;; -*- lexical-binding: t; -*-

(d:module
 '((packages rust-mode))

 (add-hook 'rust-mode-hook #'eglot-ensure)
 (add-hook 'rust-ts-mode-hook #'eglot-ensure)

 (with-eval-after-load 'eglot
   (add-to-list 'eglot-server-programs
                '((rust-ts-mode rust-mode) . ("/home/d/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer")))))

(provide 'd-rust2)
