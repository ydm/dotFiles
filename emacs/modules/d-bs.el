;; -*- lexical-binding: t -*-

(require 'advice)          ; ad-get-advice-info-field ad-remove-advice

(defun d:bs/kill-buffer-p (buffer)
  "Given a buffer, return t if it should be killed and nil
otherwise."
  (let ((mode (buffer-local-value 'major-mode buffer))
        (name (buffer-name buffer))
        (protected '("*Messages*" "*scratch*")))
    ;; Do not kill a buffer if any of the following is met.
    (not (or
          (buffer-file-name b)        ; Buffer visits a file.
          (eq mode 'dired-mode)       ; Buffer is in dired-mode.
          (get-buffer-process buffer) ; Buffer has an associated proc.
          (get-buffer-window buffer)  ; Buffer is displayed.
          (member name protected))))) ; Buffer is protected.

(when (ad-get-advice-info-field 'bs-show 'before)
  (ad-remove-advice 'bs-show 'before 'd:bs/clean))

(defadvice bs-show (before d:bs/clean activate)
  "Clean up the buffer list before showing bs."
  (mapc
   (lambda (b) (and (d:bs/kill-buffer-p b) (kill-buffer b)))
   (buffer-list)))

(provide 'd-bs)
