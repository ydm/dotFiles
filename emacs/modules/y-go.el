(y:module
 '((packages lsp-mode))

 (require 'lsp-mode)
 (add-hook 'go-mode-hook #'lsp-deferred)

 ;; Set up before-save hooks to format buffer and add/delete imports.
 ;; Make sure you don't have other gofmt/goimports hooks enabled.
 (defun lsp-go-install-save-hooks ()
   (add-hook 'before-save-hook #'lsp-format-buffer t t)
   (add-hook 'before-save-hook #'lsp-organize-imports t t))
 (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
 (add-hook 'go-mode-hook
           (lambda ()
             (set-fill-column 90)
             (define-key go-mode-map (kbd "C-c a") #'lsp-execute-code-action)
             ))
 (add-hook 'go-mode-hook (lambda () (message "XXX")))

 (lsp-register-custom-settings
  '(("gopls.staticcheck" t t)
    ("gopls.completeUnimported" t t))))

(provide 'y-go)
