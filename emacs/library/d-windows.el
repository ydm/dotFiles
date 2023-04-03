(setq *d:windows/previous-configuration* nil)
(setq *d:windows/current-configuration* nil)

(defun d:windows/restore ()
  (interactive)
  (and *d:windows/previous-configuration*
       (set-window-configuration *d:windows/previous-configuration*)))

(add-hook 'window-configuration-change-hook
          (lambda ()
            (setq *d:windows/previous-configuration*
                  *d:windows/current-configuration*)
            (setq *d:windows/current-configuration*
                  (current-window-configuration))))

(provide 'd-windows)
