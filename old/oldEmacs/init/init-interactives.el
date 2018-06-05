(require 'init-defuns)

;; Dependencies
;;   init-defuns:
;;     (y:insert-block-delimiter)
;;     (y:safe-to-kill-buffers)


;; +-----------------+
;; | Buffer commands |
;; +-----------------+

(defun y:switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun y:kill-system-buffers ()
  (interactive)
  (defun kill (b)
    "Kill buiffer if it starts with star."
    (and (string-prefix-p "*" (buffer-name b))
	 (kill-buffer b)))
  (mapcar #'kill (y:safe-to-kill-buffers)))


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

(defun y:wrap-in-double-quotes ()
  (interactive)
  (insert-char ?\")
  (move-end-of-line 1)
  (insert-char ?\"))

(defun y:wrap-in-parentheses ()
  (interactive)
  (insert-char ?()
  (move-end-of-line 1)
  (insert-char ?)))


;; +----------+
;; | Comments |
;; +----------+

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


(provide 'init-interactives)
