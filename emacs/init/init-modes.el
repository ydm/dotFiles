(defvar *automatic-minor-modes*
  '((errnav-minor-mode (flymake-mode-hook))
    (flymake-mode (js-mode-hook))
    (subword-mode (js-mode-hook))))

(defun y:hook-mode (e)
  (let ((minor-mode (car e))
        (hook-list (cadr e)))
    (mapcar (lambda (hook)
              (add-hook hook minor-mode))
            hook-list)))

(mapcar #'y:hook-mode *automatic-minor-modes*)

;; Enable global abbreviations
(setq-default abbrev-mode t)

;; Global modes
(add-hook 'after-init-hook (lambda () (key-chord-mode 1)))
(provide 'init-modes)
