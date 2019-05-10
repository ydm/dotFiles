(y:module
 '(atom-dark-theme)

 (mapcar #'disable-theme custom-enabled-themes)
 (load-theme 'atom-dark t))


(provide 'y-theme)
