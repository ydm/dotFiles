;; TODO: Check if this is actually needed or emacs loads bs
;; automatically beforehand!
(require 'bs)

(defun y:bs/kill-buffer-p (b)
  "\
Returns t for buffer that should be killed.

TODO: SPECIFY CONDITIONS BETTER, THE LIST ISN'T ACCURATE

Conditions are:
  1. Buffer starts with star
  2. Buffer is neither one of *Messages*, *Packages* or *scratch*
  3. Buffer doesn't have an associated process running
  4. Buffer is not int dired-mode
"
  (let ((mode (with-current-buffer b major-mode))
        (name (buffer-name b))
        (protected '("*Messages*" "*Packages*" "*scratch*")))
    (cond ((eq b (current-buffer)) nil)
          ((eq mode 'dired-mode) nil)
          ((and (string-prefix-p "*" name)
                (not (member name protected))
                (null (get-buffer-process b))))
          (t nil))))

(defadvice bs-show (before y:bs-kill-system-buffers-before-bs-show activate)
  "Clean up buffer list before showing bs"
  ;; (apply #'kill-buffer (mapcar #'p (buffer-list)))?
  (mapc (lambda (b) (and (y:bs/kill-buffer-p b) (kill-buffer b)))
        (buffer-list)))

(provide 'y-bs)
