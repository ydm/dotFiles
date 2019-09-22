(defun y:keychords/switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(y:module
 '(ace-jump-mode ace-window key-chord)

 (key-chord-mode 1)
 (key-chord-define-global "ww" #'ace-window)
 (key-chord-define-global "hh" #'ace-jump-mode)
 (key-chord-define-global "vv" #'ido-switch-buffer)
 (key-chord-define-global "jj" #'y:keychords/switch-to-last-buffer))

(provide 'y-keychords)
