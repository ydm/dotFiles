(add-to-list '*y:packages* 'smex)

(global-unset-key (kbd "M-x"))          ; (execute-extend-command)
(global-set-key (kbd "M-x") #'smex)

(provide 'init-smex)
