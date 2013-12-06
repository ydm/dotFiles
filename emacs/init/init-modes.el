(require 'init-defuns)
(require 'init-dired)

;; Dependencies:
;;   init-dired:
;;     y:dired-reuse-buffer-on-up
;;   init-defuns:
;;     y:delete-trailing-ws-by-mode
;;     y:make-file-dir

(defvar y:hook-config
  '((errnav-minor-mode (flymake-mode-hook))
    (flymake-mode (js-mode-hook))
    (subword-mode (js-mode-hook))
    ;; (y:delete-trailing-ws-by-mode (before-save-hook))
    (y:dired-reuse-buffer-on-up (dired-mode-hook))
    (y:make-file-dir (find-file-hook)))
  "Each entry of the list contains:
at position 0: a function that will be hooked,
at position 1: a list of hooks")

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

;; Global modes
(add-hook 'after-init-hook
	  (lambda ()
	    (key-chord-mode 1)))

(provide 'init-modes)
