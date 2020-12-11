;; +--------------+
;; | Coding style |
;; +--------------+

;; Chaos
(defconst *y:chaos-cpp-style*
  '("linux"
    (c-offsets-alist . ((arglist-close . 0)
			(inline-open . 0)
			(innamespace . 0)
			(member-init-intro . 0)))
    (indent-tabs-mode . t)))
(c-add-style "chaos" *y:chaos-cpp-style*)

;; My own
(defconst *y:ydm-cpp-style*
  '("stroustrup"
    (c-offsets-alist . ((arglist-close . 0)
			(inline-open . 0)
			(innamespace . 0)
			(member-init-intro . 0)))
    (indent-tabs-mode . nil)))
(c-add-style "ydm" *y:ydm-cpp-style*)

(add-hook 'c++-mode-hook
          (lambda () (hs-minor-mode 1)))

(provide 'init-c-styles)
