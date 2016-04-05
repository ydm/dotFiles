(y:install-packages caroline-theme)

(add-hook 'after-init-hook
	  (lambda ()
	    (mapcar #'disable-theme custom-enabled-themes)
	    (load-theme 'caroline t)))

(provide 'init-themes)
