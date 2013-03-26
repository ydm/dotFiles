(defun y/close-compilation-buffer-on-success (status code msg)
  (if (and (eq status 'exit) (zerop code))
      (set-window-buffer (get-buffer-window) (other-buffer))
    (progn
      (setq buffer-read-only nil)
      (apply-ansi-color-current-buffer)
      (setq buffer-read-only t)))
  (cons msg code))
(setq compilation-exit-message-function 'y/close-compilation-buffer-on-success)

(provide 'init-compilation)
