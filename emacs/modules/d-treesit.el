;; -*- lexical-binding: t -*-

(require 'cl)                           ; cl-remove-if
(require 'eglot)                        ; eglot-ensure
(require 'files)                        ; auto-mode-alist
(require 'treesit)                      ; treesit-extra-load-path

(defun y:auto-mode-alist-entries (mode)
  (cl-remove-if
   (lambda (x) (not (eq (cdr x) mode)))
   auto-mode-alist))

(defun y:auto-mode-alist-assoc-patterns (entries mode)
  (mapc (lambda (entry)
          (let ((pattern (car entry)))
            (message "[X] Associating mode %s with pattern %s" mode pattern)
            (add-to-list 'auto-mode-alist (cons pattern mode))))
        entries))

(add-to-list 'treesit-extra-load-path
             (expand-file-name "~/local/external/tree-sitter-module/dist"))

(use-package go-ts-mode
  :init (add-hook 'go-ts-mode-hook #'eglot-ensure)
  :ensure nil)

(use-package js
  :init (if-let ((treesit-ready-p 'json)
                 (entries (y:auto-mode-alist-entries 'javascript-mode)))
            (y:auto-mode-alist-assoc-patterns entries 'js-ts-mode))
  :ensure nil)

(use-package json-ts-mode
  :custom (json-ts-mode-indent-offset 4)
  :ensure nil)

(use-package typescript-ts-mode
  :init   (add-hook 'typescript-ts-mode-hook #'eglot-ensure)
  :custom (typescript-ts-mode-indent-offset 4)
  :ensure nil)

;; TODO: elisp
;; TODO: check gomod
;; TODO: python + pyright, ruby, sql, yaml, js, make, dockerfile
;; clojure?
;; TODO: c! cpp?

(provide 'd-treesit)
