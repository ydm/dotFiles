;; Each entry of the config list contains:
;; 1) Function to be executed on hook;
;; 2) List of hooks to add the function to.
(let ((config '((ansi-color-for-comint-mode-on (shell-mode-hook))
		(subword-mode (c-mode-common-hook js-mode-hook)))))
  (cl-loop for (func hooks) in config
	   do (mapcar (lambda (hook) (add-hook hook func)) hooks))
  ;; Enable abbrevs and key-chords globally

  (setq-default abbrev-mode t))

(add-hook 'after-init-hook
	  (lambda ()

	    ;; Auto-complete-mode
	    (require 'auto-complete-config)
	    (add-to-list 'ac-dictionary-directories
			 "~/dotFiles/emacs/dicts")
	    (ac-config-default)

	    ;; Key-chord-mode
	    (key-chord-mode 1)))

(provide 'init-modes)
