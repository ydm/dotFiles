;; -*- lexical-binding: t; -*-


(d:module
 ()

 ;; Register my preferred C++ style.
 (defconst *d:cpp*
   '("bsd"
     (c-basic-offset . 4)
     (tab-width . 8)
     (c-offsets-alist . ((member-init-intro . 0)
                         (innamespace . 0)
                         ;; (arglist-close . ?-)
                         ))
     ))
 (c-add-style "dcpp" *d:cpp*)

 ;; Use // comments for C-mode
 (add-hook 'c-mode-hook (lambda () (c-toggle-comment-style -1)))

 ;; Set my style as the default for C++-mode.
 (add-hook 'c++-mode-hook (lambda () (c-set-style "dcpp"))))


(provide 'd-cc)
