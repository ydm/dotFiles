;; (y:module
;;  '((packages flycheck-golangci-lint lsp-mode))

;;  (require 'lsp-mode)
;;  (add-hook 'go-mode-hook #'lsp-deferred)

;;  ;; Set up before-save hooks to format buffer and add/delete imports.
;;  ;; Make sure you don't have other gofmt/goimports hooks enabled.
;;  (defun y-lsp-go-install-save-hooks ()
;;    (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;    (add-hook 'before-save-hook #'lsp-organize-imports t t))
;;  (add-hook 'go-mode-hook #'y-lsp-go-install-save-hooks)

;;  (defun y-go-misc ()
;;    (set-fill-column 90)
;;    (define-key go-mode-map (kbd "C-c a") #'lsp-execute-code-action))
;;  (add-hook 'go-mode-hook #'y-go-misc)

;;  (lsp-register-custom-settings
;;   '(("gopls.staticcheck" t t)
;;     ("gopls.completeUnimported" t t)))

;;  (eval-after-load 'flycheck                                       
;;    '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

;;  (custom-set-variables
;;   '(flycheck-golangci-lint-enable-all t)))

(provide 'y-go)
