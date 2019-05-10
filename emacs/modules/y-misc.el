(y:module '(ag))

(defun y:push-filename-line ()
  "Push the current buffer's filename:line into the kill ring."
  (interactive)
  (let* ((filename (buffer-file-name))
           (line (line-number-at-pos))
           (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(defun y:ag (directory regexp)
  (interactive (list (read-directory-name "Directory: ")
		     (ag/read-from-minibuffer "Search regexp")))
  (ag/search regexp directory :regexp t))

(provide 'y-misc)
