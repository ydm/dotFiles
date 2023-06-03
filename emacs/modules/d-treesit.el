;; -*- lexical-binding: t -*-

(require 'cl)                           ; cl-remove-if
(require 'eglot)                        ; eglot-ensure
(require 'files)                        ; auto-mode-alist
(require 'treesit)                      ; treesit-extra-load-path

;; (defun y:auto-mode-alist-entries (mode)
;;   (cl-remove-if
;;    (lambda (x) (not (eq (cdr x) mode)))
;;    auto-mode-alist))

;; (defun y:auto-mode-alist-assoc-patterns (patterns mode)
;;   (mapc (lambda (pattern)
;;           (message "[X] Associating mode %s with pattern %s" mode pattern)
;;           (add-to-list 'auto-mode-alist (cons pattern mode)))
;;         patterns))

(add-to-list 'treesit-extra-load-path
             (expand-file-name "~/local/external/tree-sitter-module/dist"))

;; Simplest cases first
(require 'dockerfile-ts-mode)           ; modifies auto-mode-alist
(require 'js)                           ; modifies auto-mode-alist
(require 'python)                       ; modifies auto-mode-alist

(use-package c-ts-mode
  :init
  (add-hook 'c-ts-mode-hook #'eglot-ensure)
  (add-hook 'c++-ts-mode-hook #'eglot-ensure)
  :custom
  (c-ts-mode-indent-offset 2)
  (c-ts-mode-indent-style 'bsd)
  :ensure nil)

(use-package go-ts-mode
  :init (add-hook 'go-ts-mode-hook #'eglot-ensure)
  :ensure nil)

;; (use-package js
;;   ;; Get all `auto-mode-alist' patterns that are associated with
;;   ;; `javascript-mode' and re-associate them with `js-ts-mode'.
;;   :init (if-let ((treesit-ready-p 'json)
;;                  (entries (y:auto-mode-alist-entries 'javascript-mode)))
;;             (y:auto-mode-alist-assoc-patterns (mapcar #'car entries) 'js-ts-mode))
;;   :ensure nil)


(use-package json-ts-mode
  :custom (json-ts-mode-indent-offset 4)
  :ensure nil)

(use-package typescript-ts-mode
  :init
  ;; Associate cts files with `typescript-ts-mode'.
  (add-to-list 'auto-mode-alist (cons "\\.cts\\'" 'typescript-ts-mode))
  (add-hook 'typescript-ts-mode-hook #'eglot-ensure)
  :custom (typescript-ts-mode-indent-offset 4)
  :ensure nil)

;; TODO: elisp
;; TODO: check gomod
;; TODO: python + pyright, ruby, sql, yaml, js, make, dockerfile
;; clojure?
;; TODO: c! cpp?

(provide 'd-treesit)
