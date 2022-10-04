(y:module
 ()
 (add-hook 'html-mode (lambda () (electric-indent-mode -1))))

(provide 'y-html)
