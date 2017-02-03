(defun y:init-bs/should-kill-buffer-p (b)
  "\
Returns t for buffer that should be killed.

Conditions are:
  1. Buffer starts with star;
  2. Buffer is neither one of *Messages*, *Packages* or *scratch*;
  3. Buffer doesn't have an associated process running."
  (let ((mode (with-current-buffer b major-mode))
        (name (buffer-name b))
        (protected '("*Messages*" "*Packages*" "*scratch*")))
    (cond ((eq b (current-buffer)) nil)
          ((eq mode 'dired-mode) t)
          ((and (string-prefix-p "*" name)
                (not (member name protected))
                (null (get-buffer-process b))) t)
          (t nil))))

(defadvice bs-show (before y:bs-kill-system-buffers-before-bs-show activate)
  "Clean up buffer list before showing bs"
  (cl-loop for b in (buffer-list)
	   when (y:init-bs/should-kill-buffer-p b)
	   do (kill-buffer b)))

(provide 'init-bs)
