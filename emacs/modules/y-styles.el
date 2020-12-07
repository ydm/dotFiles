(y:module
 ()

 ;; Register new C++ style, called "mine"
 (defconst *y:my-cpp-style*
   '("bsd"
     (c-basic-offset . 4)
     (tab-width . 8)
     (c-offsets-alist . ((member-init-intro . 0)
                         (innamespace . 0)
                         ;; (arglist-close . ?-)
                         ))
     ))
 (c-add-style "mine" *y:my-cpp-style*)

 ;; Use // comments for C-mode
 ;;
 ;; XXX: I should read the cc-mode documentation!  Pretty sure there's
 ;; an elegant way to do that.
 (add-hook 'c-mode-hook (lambda () (c-toggle-comment-style -1)))

 ;; Set my style as the default for C++-mode and also turn on the
 ;; Hide Show minor mode.
 ;;
 ;; XXX: Again, I should read the cc-mode documentation!
 (add-hook 'c++-mode-hook
           (lambda ()
             (c-set-style "mine")
             (hs-minor-mode 1)))

 ;; XXX: Is it better for this to be done in ~/.emacs ?
 (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
 )

(provide 'y-styles)
