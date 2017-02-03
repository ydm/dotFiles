;; Miscellaneous functions and utilities

(defun y:cppfilt ()
  (interactive)
  (let* ((symbol (symbol-at-point))
         (cmd    (format "c++filt \"%s\"" symbol))
         (output (shell-command-to-string cmd)))
    (message output)))

(defun y:push-filename-line ()
  "Push the current buffer's filename:line into the kill ring."
  (interactive)
  (let* ((filename (buffer-file-name))
           (line (line-number-at-pos))
           (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(defun y:locate-breakpoint ()
  "When you ask gdb for your breakpoints, you may also want to
  locate them.  Well, in this case you ask this guy for help."
  (interactive)
  (let* ((str (buffer-substring-no-properties
               (line-beginning-position) (line-end-position)))
         (file-and-line (car (last (split-string str))))
         (split (split-string file-and-line ":"))
         (filename (car split))
         (lineno (string-to-number (cadr split))))
    (ffap filename)
    (goto-line lineno)))

(provide 'init-misc)
