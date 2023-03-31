;; -*- lexical-binding: t; -*-


(d:module
 '((packages rust-mode))

 (add-hook 'rust-mode-hook #'eglot-ensure)

 (add-hook 'rust-mode-hook
           (lambda ()
             (define-key rust-mode-map (kbd "C-<next>") #'flymake-goto-next-error)
             (define-key rust-mode-map (kbd "C-<prior>") #'flymake-goto-prev-error)
             (define-key rust-mode-map (kbd "M-<f1>") #'eglot-code-actions)
             (define-key rust-mode-map (kbd "M-<f2>") #'eglot-rename)
             (define-key rust-mode-map (kbd "s-i") #'eglot-format))))

             ;; (define-key go-mode-map (kbd "M-2") #'eglot-code-action-extract)
             ;; (define-key go-mode-map (kbd "M-3") #'eglot-code-action-inline)
             ;; (define-key go-mode-map (kbd "M-4") #'eglot-code-action-organize-imports)
             ;; (define-key go-mode-map (kbd "M-5") #'eglot-code-action-quickfix)
             ;; (define-key go-mode-map (kbd "M-6") #'eglot-code-action-rewrite)
             ;; (define-key go-mode-map (kbd "M-8") #'eglot-format))))

(provide 'd-rust)
