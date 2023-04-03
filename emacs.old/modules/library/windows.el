(setq *d:previous-window-configuration* nil)
(setq *d:current-window-configuration* nil)

(defun d:restore-windows ()
  (interactive)
  (and *d:previous-window-configuration*
       (set-window-configuration *d:previous-window-configuration*)))

(add-hook 'window-configuration-change-hook
          (lambda ()
            (setq *d:previous-window-configuration*
                  *d:current-window-configuration*)
            (setq *d:current-window-configuration*
                  (current-window-configuration))))

(provide 'd-library-windows)
