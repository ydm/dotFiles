;; +-----------+
;; | C++ style |
;; +-----------+

(defconst *y:chaos-cpp-style*
  '("linux"
    (c-offsets-alist . ((arglist-close . 0)
			(inline-open . 0)
			(innamespace . 0)
			(member-init-intro . 0)))
    (indent-tabs-mode . t)))
(c-add-style "chaos" *y:chaos-cpp-style*)


(provide 'y-chaos)
