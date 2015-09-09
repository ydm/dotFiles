(defvar y:hook-config
  '((ansi-color-for-comint-mode-on (shell-mode-hook))
    (subword-mode (c-mode-common-hook js-mode-hook))
    ;; (y:delete-trailing-ws (before-save-hook)))
    )
  "Each entry of this list contains:
1) Function to be hooked,
2) List of hooks to add the function to.")

(cl-loop for (func hooks) in y:hook-config
	 do (mapcar (lambda (hook) (add-hook hook func)) hooks))

;; Enable abbrevs and key-chords globally
(setq-default abbrev-mode t)
(add-hook 'after-init-hook (lambda () (key-chord-mode 1)))

(provide 'init-modes)
