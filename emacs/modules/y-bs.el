;; TODO: Check if this is actually needed or emacs loads bs
;; automatically beforehand!
(require 'bs)

(defun y:bs/kill-buffer-p (b)
  "Given a buffer, return t if it should be killed and nil otherwise."
  (let ((mode (buffer-local-value 'major-mode b))
        (name (buffer-name b))
        (protected '("*Messages*" "*scratch*")))
    ;; (message "mode=%s name=%s current=%s window=%s process=%s protected=%s modified=%s file-name=%s"
    ;;          mode
    ;;          name
    ;;          (eq b (current-buffer))
    ;;          (get-buffer-window b)
    ;;          (get-buffer-process b)
    ;;          (member name protected)
    ;;          (buffer-modified-p b)
    ;;          (buffer-file-name b))
    
    ;; Don't kill buffer in any of the following conditions
    (not (or
          ;; This is the current buffer
          (eq b (current-buffer))
          ;; The buffer is displayed in a window
          (get-buffer-window b)
          ;; The buffer has an associated process
          (get-buffer-process b)
          ;; Buffer is protected
          (member name protected)
          ;; Buffer is visiting a file
          (buffer-file-name b)))))

(defadvice bs-show (before y:bs-kill-system-buffers-before-bs-show activate)
  "Clean up buffer list before showing bs"
  (mapc (lambda (b) (and (y:bs/kill-buffer-p b) (kill-buffer b)))
        (buffer-list)))

(provide 'y-bs)
