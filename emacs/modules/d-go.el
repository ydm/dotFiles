;; -*- lexical-binding: t; -*-


(d:module
 '((packages go-mode eglot))
 ;;
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
 (add-hook 'go-mode-hook #'eglot-ensure))


(provide 'd-go)
