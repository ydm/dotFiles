;; -*- lexical-binding: t; -*-

(require 'vc-dir)

(define-key vc-dir-mode-map (kbd "/") #'vc-git-grep)

(provide 'd-vc)
