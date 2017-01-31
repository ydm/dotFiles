(y:install-packages caroline-theme molokai-theme)

(add-hook 'after-init-hook
	  (lambda ()
	    (mapcar #'disable-theme custom-enabled-themes)
	    (load-theme 'molokai t)))

(provide 'init-themes)
