(y:install-packages smex)

(global-unset-key (kbd "M-x"))          ; (execute-extend-command)
(global-set-key (kbd "M-x") #'smex)
(global-set-key (kbd "<f13>") #'smex)

(provide 'init-smex)
