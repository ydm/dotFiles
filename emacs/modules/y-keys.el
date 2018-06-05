(defun y:keys/open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(y:module
 nil

 (global-unset-key (kbd "C-o"))		; open-line
 (global-unset-key (kbd "C-x C-b")) 	; list-buffers
 (global-unset-key (kbd "C-x o"))  	; other-frame
 (global-unset-key (kbd "C-z"))		; suspend-frame

 (global-set-key (kbd "C-o") #'y:keys/open-line)
 (global-set-key (kbd "C-x C-b") #'bs-show))

(provide 'y-keys)
