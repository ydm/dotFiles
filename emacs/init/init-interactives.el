(require 'ansi-color)

(defun string-startswith (s1 s2)
  (if (or (not (stringp s1)) (not (stringp s2)) (string< s1 s2))
      nil
    (string= (substring s1 0 (length s2)) s2)))

(defun unwanted-buffers (&optional wanted)
  (unless wanted (setq wanted '("*Messages*" "*scratch*")))
  (defun wantedp (b)
    (or (member (buffer-name b) wanted) (get-buffer-process b)))
  (require 'cl)                         ; TODO: use the new cl library
  (remove-if 'wantedp (buffer-list)))

;; +----------+
;; | Commands |
;; +----------+
(defun apply-ansi-color-current-buffer (&optional buffer)
  (interactive)
  (unless buffer
    (setq buffer (current-buffer)))
  (with-current-buffer buffer
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun kill-system-buffers ()
  (interactive)
  (dolist (b (unwanted-buffers))
    (if (string-startswith (buffer-name b) "*")
	(kill-buffer b))))

(defun clear ()
  (interactive)
  (kill-system-buffers)
  (kill-some-buffers (unwanted-buffers)))

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

(provide 'init-interactives)
