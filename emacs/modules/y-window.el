(setq *y:previous-window-configuration* nil)
(setq *y:current-window-configuration* nil)

(defun y:restore-windows ()
  (interactive)
  (and *y:previous-window-configuration*
       (set-window-configuration *y:previous-window-configuration*)))

(add-hook 'window-configuration-change-hook
          (lambda ()
            (setq *y:previous-window-configuration*
                  *y:current-window-configuration*)
            (setq *y:current-window-configuration*
                  (current-window-configuration))))

(provide 'y-window)
