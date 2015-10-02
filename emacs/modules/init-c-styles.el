;; (custom-set-variables
;;  '(indent-tabs-mode t))

;; Chaos coding style
(defconst chaos-c-style
  '("linux"
    (c-offsets-alist . ((arglist-close . 0)
			(inline-open . 0)
			(innamespace . 0)
			(member-init-intro . 0)))
    (indent-tabs-mode t)
    (setq tab-width 4)))

(c-add-style "chaos" chaos-c-style)

;; Add to ~/.emacs.d/init/post.el:
;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; (add-to-list 'c-default-style '(c++-mode . "chaos"))

(add-hook 'c-mode-common-hook (lambda () (subword-mode 1)))
(provide 'init-c-styles)
