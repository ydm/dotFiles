(add-to-list '*y:packages* 'ace-jump-mode)
(add-to-list '*y:packages* 'key-chord)

(defun y:init-keychords ()
  (let ((chords '(("jj" . y:switch-to-last-buffer)
		  ("hh" . ace-jump-mode)
		  ("vv" . ido-switch-buffer))))
    (key-chord-mode 1)
    (cl-loop for (chord . fn) in chords do
	     (key-chord-define-global chord fn))))

(add-hook 'after-init-hook #'y:init-keychords)

(provide 'init-keychords)
