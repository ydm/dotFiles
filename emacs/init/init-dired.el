(put 'dired-find-alternate-file 'disabled nil) ; allow nav in dired buffer

(defun y/dired-reuse-buffer-on-up ()
  (define-key dired-mode-map (kbd "^")
    (lambda ()
      (interactive)
      (find-alternate-file ".."))))
(add-hook 'dired-mode-hook 'y/dired-reuse-buffer-on-up)

(provide 'init-dired)
