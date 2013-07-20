(require 'init-defuns)

;; Dependencies:
;;   init-defuns:
;;     y:ansi-color-apply-on-buffer

(defun y:on-compilation-finish (buffer msg)
  (with-current-buffer buffer
    (if (zerop exit-status)
        (set-window-buffer (get-buffer-window) (other-buffer))
      (progn
        (setq buffer-read-only nil)
        (y:ansi-color-apply-on-buffer)
        (setq buffer-read-only t)))))

;; (add-to-list 'compilation-finish-functions #'y:on-compilation-finish)

(provide 'init-compilation)
