(require 'init-defuns)

;; Dependencies:
;;   init-defuns:
;;     (y:reuse-dired-buffer-on-up)
;;
;; XXX: This module depends on all modes to be loaded.

(defvar y:hook-config
  '((ansi-color-for-comint-mode-on (shell-mode-hook))
    (subword-mode (js-mode-hook))
    (y:reuse-dired-buffer-on-up (dired-mode-hook))
    ;; (errnav-minor-mode (flymake-mode-hook))
    ;; (flymake-jslint-load (js-mode-hook))
    ;; (y:delete-trailing-ws (before-save-hook))
    )
  "Each entry of this list contains:
1) a function that will be hooked,
2) a list of hooks to bind the function to.")

(defun y:apply-hooks (e)
  (let ((func (car e))
        (hook-list (cadr e)))
    (mapcar (lambda (hook)
              ;; (message "(add-hook %s %s)" hook func)
              (add-hook hook func))
            hook-list)))

(mapcar #'y:apply-hooks y:hook-config)

;; Enable global abbreviations
(setq-default abbrev-mode t)

(add-hook 'after-init-hook
	  (lambda ()
	    (key-chord-mode 1)))

(provide 'init-modes)
