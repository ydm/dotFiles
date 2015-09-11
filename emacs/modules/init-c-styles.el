;; (custom-set-variables
;;  '(indent-tabs-mode t))

;; Chaos coding style
(defconst chaos-c-style
  '("linux"
    (c-offsets-alist . ((arglist-close . 0)
			(innamespace . 0)))
    (indent-tabs-mode t)))

(c-add-style "chaos" chaos-c-style)
;; Add to ~/.emacs.d/init/post.el:
;; (setq c-default-style "chaos")

(provide 'init-c-styles)
