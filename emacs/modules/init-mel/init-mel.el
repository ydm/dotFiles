(autoload 'mel-mode "mel-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.mel$" . mel-mode))
(add-hook 'mel-mode-hook
	  (lambda ()
	    ;; 1. Subword mode
	    (subword-mode)
	    ;; 2. E2M
	    (require 'e2m)
	    (local-set-key (kbd "C-c C-c") #'e2m/send-buffer)
	    (local-set-key (kbd "C-c C-v") #'e2m/send-line)))

(provide 'init-mel)
