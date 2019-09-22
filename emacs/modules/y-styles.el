(y:module
 ()

 (defconst *y:my-cpp-style*
   '("bsd"
     (c-basic-offset . 4)
     (tab-width . 4)
     (c-offsets-alist . ((arglist-close . 0)
                         (member-init-intro . 0)
                         (innamespace . 0)))))
 (c-add-style "mine" *y:my-cpp-style*)
 (add-hook 'c++-mode-hook (lambda () (c-set-style "mine"))))

(provide 'y-styles)

