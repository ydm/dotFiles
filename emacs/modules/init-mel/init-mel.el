(autoload 'mel-mode "mel-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.mel$" . mel-mode))

(add-hook 'mel-mode-hook
	  (lambda ()
	    (require 'e2m)
	    (local-set-key (kbd "C-c C-c") #'e2m/send-buffer)
	    (local-set-key (kbd "C-c C-q") #'e2m/send-quick)
	    (local-set-key (kbd "C-c C-z") #'e2m/display-maya-buffer)))

(provide 'init-mel)
