(require 'init-defuns)
;; (require 'cl)

;; Dependencies
;;   init-defuns:
;;     (y:python-main-buffers)
;;     (y:string-startswith)
;;     (y:unwanted-buffers)

;; +----------+
;; | Commands |
;; +----------+

(defun y:beautifyjs ()
  "Run beautifier nodejs package on current file."
  (interactive)
  (let* ((orgfile (buffer-file-name))
         (tmpfile (format "%s_beautify" orgfile)))
    (save-buffer)
    ;; TODO: Check if the file ends in .js.
    (shell-command (format "beautifier %s > %s" orgfile tmpfile))
    (delete-file orgfile)
    (rename-file tmpfile orgfile)
    (find-alternate-file orgfile)))

(defun y:clear ()
  (interactive)
  (y:kill-system-buffers)
  (kill-some-buffers (y:unwanted-buffers)))

(defun y:comment-box ()
  (interactive)
  (let* ((start (line-beginning-position))
         (end (line-end-position))
         (line (buffer-substring-no-properties start end))
         (match (string-match
                 "\\([[:space:]]*\\)\\([^[:space:]]+\\)[[:space:]]+\\(.*\\)"
                 line))
         (initial-space (if (null match) nil (match-string 1 line)))
         (comment-start (if (null match) nil (match-string 2 line)))
         (comment-body (if (null match) nil (match-string 3 line))))
    (unless (null initial-space)
      (delete-region start end)

      (defun y:box-insert (s)
        (insert (format "%s%s %s\n"  initial-space comment-start s)))

      (let ((border (format
                     "+%s+"
                     (make-string (+ 2 (length comment-body)) ?-))))
        (y:box-insert border)
        (y:box-insert (format "| %s |" comment-body))
        (y:box-insert border)))))

(defun y:delete-file ()
  "Delete the file behind the current buffer and kill the buffer
afterwards."
  (interactive)
  (delete-file (buffer-file-name))
  (kill-buffer))

(defun y:kill-system-buffers ()
  (interactive)
  (defun kill (b)
    "Kill buiffer if it's a system buffer. "
    (if (y:string-startswith (buffer-name b) "*")
        (kill-buffer b)))
  (mapcar #'kill (y:unwanted-buffers)))

(defun y:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

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

(defun y:replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))

(defvar y:python-last-run-buffer 'nil
  "The buffer that's last run by the (python-run) function.")

(defun y:python-run (&optional show-python-shell)
  (interactive)
  (let* ((dedicated-proc-name (python-shell-get-process-name t))
         (dedicated-proc-buffer-name (format "*%s*" dedicated-proc-name))
         (dedicated-running (comint-check-proc dedicated-proc-buffer-name)))
    ;; If there's already a python shell running for this buffer, kill it
    (when dedicated-running
      (let* ((process (python-shell-get-or-create-process))
             (buffer (process-buffer process)))
        (set-process-query-on-exit-flag process nil)
        (kill-buffer buffer)))
    ;; Start new python shell
    (let ((window (selected-window)))
      (run-python python-shell-interpreter t show-python-shell)
      (python-shell-send-buffer t)
      (select-window window)
      (setq y:python-last-run-buffer (current-buffer)))))

(defun y:python-run-main (&optional show-python-shell)
  (interactive)
  (let ((main (car (y:python-main-buffers
                    (if (local-variable-p 'run-by) run-by)))))
    (when main
      (with-current-buffer main
        (y:python-run show-python-shell)))))

(defun y:python-rerun (&optional show-python-shell)
  (interactive)
  (when y:python-last-run-buffer
      (message "last-run-buffer=%s" y:python-last-run-buffer)
      (with-current-buffer y:python-last-run-buffer
        (y:python-run show-python-shell))))

(provide 'init-interactives)
