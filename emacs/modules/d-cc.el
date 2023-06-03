;; -*- lexical-binding: t -*-

;; (require 'c-ts-mode)
;; (use-package c-ts-mode :ensure nil)

;; (add-hook 'c-ts-mode-hook (lambda () (c-toggle-comment-style -1)))

;; (defconst *d:cpp*
;;   '("bsd"
;;     (c-basic-offset . 4)
;;     (tab-width . 8)
;;     (c-offsets-alist . ((member-init-intro . 0)
;;                         (innamespace . 0)
;;                         ;; (arglist-close . ?-)
;;                         ))
;;     ))
;; (c-add-style "dcpp" *d:cpp*)
;; (add-hook 'c++-ts-mode-hook (lambda () (c-set-style "dcpp")))



(provide 'd-cc)
