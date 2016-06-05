(y:install-packages smex)

(global-unset-key (kbd   "M-x"))        ; (execute-extend-command)
(global-set-key   (kbd   "M-x") (function smex))
(global-set-key   (kbd "<f13>") (function smex))

(provide 'init-smex)
