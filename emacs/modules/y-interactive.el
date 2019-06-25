(defun y:block-comment (comment)
  (interactive "sLabel: ")
  (cl-labels ((insert-commented (str wrapper filling)
				(indent-according-to-mode)
				(insert (comment-padright comment-start (comment-add nil)))
				(insert-char wrapper)
				(insert-char filling)
				(insert str)
				(insert-char filling)
				(insert-char wrapper)
				(insert-char ?\n)))
    (let ((rule (make-string (length comment) ?-)))
      (save-excursion
	(insert-commented rule ?+ ?-)
	(insert-commented comment ?| ? )
	(insert-commented rule ?+ ?-)))))

(defun y:push-filename-line ()
  "Push the current buffer's filename:line into the kill ring."
  (interactive)
  (let* ((filename (buffer-file-name))
           (line (line-number-at-pos))
           (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(provide 'y-interactive)
