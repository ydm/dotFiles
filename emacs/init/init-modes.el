(defvar *automatic-minor-modes*
  '((errnav-minor-mode (flymake-mode-hook))
    (flymake-mode (js-mode-hook))
    (subword-mode (js-mode-hook))))

(dolist (el *automatic-minor-modes*)
  (let ((mode (car el)))
    (dolist (hook (cadr el))
      (add-hook hook mode))))

;; Enable global abbreviations
(setq-default abbrev-mode t)

;; Global modes
(add-hook 'after-init-hook (lambda () (key-chord-mode 1)))
(add-hook 'after-init-hook (lambda () (tabbar-mode 1)))

(provide 'init-modes)
