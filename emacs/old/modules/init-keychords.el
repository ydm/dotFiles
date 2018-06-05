(y:install-packages ace-jump-mode key-chord)

(defun y:init-keychords/switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(add-hook 'after-init-hook
	  (lambda ()
	    (let ((chords '(("hh" ace-jump-mode)
			    ("vv" ido-switch-buffer)
                            ("jj" y:init-keychords/switch-to-last-buffer)
                            ("ww" ace-window))))
	      (key-chord-mode 1)
	      (cl-loop for (chord fn) in chords do
		       (key-chord-define-global chord fn)))))

(provide 'init-keychords)
