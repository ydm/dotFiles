;; -*- lexical-binding: t; -*-

(d:module
 '((packages ripgrep))

 (require 'dired)
 (require 'ripgrep)

 (define-key dired-mode-map (kbd "/")
   (lambda (needle)
     (interactive "sSearch for: ")
     ;; TODO
     (ripgrep-regexp needle default-directory))))

(provide 'd-ripgrep)
