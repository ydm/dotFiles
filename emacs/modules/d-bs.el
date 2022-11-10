;; -*- lexical-binding: t; -*-


(require 'bs)


(defun d:bs-kill-buffer-p (b)
  "Given a buffer, return t if it should be killed and nil otherwise."
  (let ((mode (buffer-local-value 'major-mode b))
        (name (buffer-name b))
        (protected '("*Messages*" "*scratch*")))

    ;; Don't kill buffer if any of the following conditions is true.
    (not (or
          ;; 1. This is the current buffer.
          (eq b (current-buffer))
          ;; 2. The buffer is displayed in a window.
          (get-buffer-window b)
          ;; 3. The buffer has an associated process.
          (get-buffer-process b)
          ;; 4. Buffer is protected.
          (member name protected)
          ;; 5. Buffer is visiting a file.
          (buffer-file-name b)))))


(defadvice bs-show (before d:bs-kill-system-buffers-before-bs-show activate)
  "Clean up buffer list before showing bs"
  (mapc (lambda (b) (and (d:bs-kill-buffer-p b) (kill-buffer b)))
        (buffer-list)))


(provide 'd-bs)
