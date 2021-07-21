(y:module
 '((packages challenger-deep-theme ;; doom-themes
             )
   (hookvar . y-theme-hook))

 (when (display-graphic-p)
   (mapcar #'disable-theme custom-enabled-themes)
   (load-theme 'challenger-deep t)
   ;; (load-theme 'doom-dark+ t)
   ))

(provide 'y-theme)
