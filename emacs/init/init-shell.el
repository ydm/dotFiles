;; https://github.com/magnars/.emacs.d/blob/master/setup-shell.el

(defun y/shell-del-eof-kill ()
  (define-key shell-mode-map (kbd "C-d")
    (lambda (arg)
      (interactive "p")
      (if (null (get-buffer-process (current-buffer)))
          (kill-buffer)
        (comint-delchar-or-maybe-eof arg)))))

(add-hook 'shell-mode-hook 'y/shell-del-eof-kill)
(add-hook 'shell-mode-hook (lambda () (shell-dirtrack-mode -1)))
(add-hook 'shell-mode-hook (lambda () (dirtrack-mode 1)))

(provide 'init-shell)
