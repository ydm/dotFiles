(defun delete-buffer-file ()
  "Delete the file behind the current buffer and kill the buffer
afterwards."
  (interactive)
  (delete-file (buffer-file-name))
  (kill-buffer))

(defun rename-buffer-file (new)
  "Rename the file behind the current buffer."
  (interactive "sNew filename: ")
  (let ((old (buffer-file-name)))
    (rename-file old new)
    (find-alternate-file new)))

;; (defun string-startswith (s1 s2)
;;   (if (or (not (stringp s1)) (not (stringp s2)) (string< s1 s2))
;;       nil
;;     (string= (substring s1 0 (length s2)) s2)))
