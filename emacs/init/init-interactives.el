(require 'ansi-color)
(require 'cl)
(require 'init-defuns)

;; +----------+
;; | Commands |
;; +----------+
(defun y:beautifyjs ()
  "Run beautifier (which comes as nodejs package) on current file."
  (interactive)
  (let* ((orgfile (buffer-file-name))
         (tmpfile (format "%s_beautify" orgfile)))
    (save-buffer)
    ;; TODO: Check if file ends in .js.
    (shell-command (format "beautifier %s > %s" orgfile tmpfile))
    (delete-file orgfile)
    (rename-file tmpfile orgfile)
    (find-alternate-file orgfile)))

(defun y:clear ()
  (interactive)
  (y:kill-system-buffers)
  (kill-some-buffers (y:unwanted-buffers)))

(defun y:delete-file ()
  "Delete the file behind the current buffer and kill the buffer
afterwards."
  (interactive)
  (delete-file (buffer-file-name))
  (kill-buffer))

(defun y:kill-system-buffers ()
  (interactive)
  (defun kis (b)
    "[K]ill buiffer [i]f it's a [s]ystem buffer. "
    (if (y:string-startswith (buffer-name b) "*")
        (kill-buffer b)))
  (mapcar #'kis (y:unwanted-buffers)))

(defun y:rename-file (new)
  "Rename the file behind the current buffer.  Credits go to
Emacs Redux"
  (interactive "sNew file name: ")
  (if (and (< 0 (length new))
           (file-exists-p (buffer-file-name)))
      (cond
       ((vc-backend (buffer-file-name))
        (vc-rename-file (buffer-file-name) new))
       (t
        (let ((modified (buffer-modified-p)))
          (rename-file (buffer-file-name) new t)
          (rename-buffer new)
          (set-visited-file-name new)
          (set-buffer-modified-p modified))))
    (message "Buffer is not visiting a file.")))

(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))

(provide 'init-interactives)
