(add-to-list '*y:packages* '(init-smex smex))

(global-unset-key (kbd "M-x"))          ; (execute-extend-command)
(global-set-key (kbd "M-x") #'smex)

(provide 'init-smex)
