(y:module
 '((packages molokai-theme)
   (hookvar . y-theme-hook))

 (mapcar #'disable-theme custom-enabled-themes)
 (load-theme 'molokai t)
 ;; (load-theme 'atom-dark t)
 )

(provide 'y-theme)
