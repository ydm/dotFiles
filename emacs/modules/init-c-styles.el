;; Open .h files in C++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Chaos coding style
(defconst chaos-c-style
  '("linux"
    (c-offsets-alist . ((arglist-close . 0)
			(inline-open . 0)
			(innamespace . 0)
			(member-init-intro . 0)))
    (indent-tabs-mode . t)))
(c-add-style "chaos" chaos-c-style)

;; My own coding style
(defconst ydm-c-style
  '("stroustrup"
    (c-offsets-alist . ((arglist-close . 0)
			(inline-open . 0)
			(innamespace . 0)
			(member-init-intro . 0)))
    (indent-tabs-mode . nil)))
(c-add-style "ydm" ydm-c-style)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (hs-minor-mode 1)
	    (subword-mode 1)))

(provide 'init-c-styles)
