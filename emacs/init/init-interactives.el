(require 'init-defuns)

;; Dependencies
;;   init-defuns:
;;     (y:insert-block-delimiter)
;;     (y:python-main-buffers)
;;     (y:string-startswith)
;;     (y:unwanted-buffers)


;; +-------------------------+
;; | Buffer related commands |
;; +-------------------------+

(defun y:kill-system-buffers ()
  (interactive)
  (defun kill (b)
    "Kill buiffer if it's a system buffer. "
    (if (y:string-startswith (buffer-name b) "*")
        (kill-buffer b)))
  (mapcar #'kill (y:unwanted-buffers)))


;; +---------------+
;; | File commands |
;; +---------------+

(defun y:delete-file ()
  "Delete the file behind the current buffer and kill the buffer
afterwards."
  (interactive)
  (delete-file (buffer-file-name))
  (kill-buffer))


;; +---------+
;; | Editing |
;; +---------+

(defun y:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun y:replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))


;; +----------+
;; | Comments |
;; +----------+

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

(defun y:comment-block (start end title)
  (interactive "r\nsBlock title: ")
  (let ((start-line (line-number-at-pos start))
        (end-line (line-number-at-pos end)))
    (save-excursion
      (goto-char start)
      (y:insert-block-delimiter title)
      (while (<= (line-number-at-pos) end-line)
        (end-of-line)
        (when (< (current-column) 78)
          (while (< (current-column) 78)
            (insert-char ? ))
          (insert-char ?#))
        (next-line))
      (y:insert-block-delimiter ""))))


;; +--------+
;; | Python |
;; +--------+

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

    ;; Set current buffer as the last run buffer
    (setq y:python-last-run-buffer (buffer-name (current-buffer)))

    ;; Start new python shell
    (run-python python-shell-interpreter t show-python-shell)
    (python-shell-send-buffer t)
    (select-window (selected-window))))

(defun y:python-run-main (&optional show-python-shell)
  (interactive)
  (let ((main (car (y:python-main-buffers
                    (if (local-variable-p 'run-by) run-by)))))
    (when main
      (with-current-buffer main
        (y:python-run show-python-shell)))))

(defun y:python-rerun (&optional show-python-shell)
  (interactive)
  (let ((buffer (y:get-buffer y:python-last-run-buffer)))
    (when buffer
      (with-current-buffer buffer
        (y:python-run show-python-shell)))))

(provide 'init-interactives)
