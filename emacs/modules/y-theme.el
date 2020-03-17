(y:module
 '((packages atom-dark)
   (hookvar . y-theme-hook))

 (mapcar #'disable-theme custom-enabled-themes)
 (load-theme 'atom-dark t)
 )

(provide 'y-theme)
