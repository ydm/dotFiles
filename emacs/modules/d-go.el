;; -*- lexical-binding: t; -*-


(d:module
 '((packages go-mode))

 ;; eglot arguments:
 ;;
 ;; - VALUES:
 ;;     - managed-major-mode=(go-mode)
 ;;     - project=(projectile . /home/d/dev/something)
 ;;     - class=eglot-lsp-server
 ;;     - contact=(gopls)
 ;;     - language-id=go
 ;;   
 ;; - OUTER TYPES:
 ;;     - managed-major-mode=cons
 ;;     - project=cons
 ;;     - class=symbol
 ;;     - contact=cons
 ;;     - language-id=string
 ;;   
 ;; - INNER TYPES:
 ;;     - managed-major-mode=symbol
 ;;     - project=(symbol string)
 ;;     - contact=string
 ;;
 (add-hook 'go-mode-hook #'eglot-ensure)

 (add-hook 'go-mode-hook
           (lambda ()
             (define-key go-mode-map (kbd "M-1") #'eglot-code-actions)
             (define-key go-mode-map (kbd "M-2") #'eglot-code-action-extract)
             (define-key go-mode-map (kbd "M-3") #'eglot-code-action-inline)
             (define-key go-mode-map (kbd "M-4") #'eglot-code-action-organize-imports)
             (define-key go-mode-map (kbd "M-5") #'eglot-code-action-quickfix)
             (define-key go-mode-map (kbd "M-6") #'eglot-code-action-rewrite)
             (define-key go-mode-map (kbd "M-7") #'eglot-rename)
             (define-key go-mode-map (kbd "M-8") #'eglot-format))))

(provide 'd-go)
