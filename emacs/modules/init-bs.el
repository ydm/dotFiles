(defun y:init-bs/should-kill-buffer-p (b)
  "\
Returns t for buffer that should be killed.

Conditions are:
  1. Buffer starts with star;
  2. Buffer is neither one of *Messages*, *Packages* or *scratch*;
  3. Buffer doesn't have an associated process running."
  (and (string-prefix-p "*" (buffer-name b))
       (not (member (buffer-name b) '("*Messages*" "*Packages*" "*scratch*")))
       (null (get-buffer-process b))))

(defadvice bs-show (before y:bs-kill-system-buffers-before-bs-show activate)
  "Clean up buffer list before showing bs"
  (cl-loop for b in (buffer-list)
	   when (y:init-bs/should-kill-buffer-p b)
	   do (kill-buffer b)))

(provide 'init-bs)
