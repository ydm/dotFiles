(y:module
 ()

 ;; Turn off the electric-indent-mode for the rare cases I have to
 ;; suffer with HTML.
 (add-hook 'html-mode (lambda () (electric-indent-mode -1))))

(provide 'd-html)
