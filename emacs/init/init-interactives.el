(require 'ansi-color)
(require 'cl)

(defun string-startswith (str head)
  (and (stringp str)
       (stringp head)
       (string= head
                (substring str 0
                           (min (length str)
                                (length head))))))

(defun unwanted-buffers (&optional wanted)
  (unless wanted (setq wanted '("*Django: " "*Messages*" "*scratch*")))
  (defun wantedp (b)
    (or (get-buffer-process b)
        (remove nil
                (mapcar (lambda (p) (string-match p (buffer-name b)))
                        wanted))))
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

;; TODO: Check if file ends in .js.
(defun beautify ()
  "Run beautifier (which comes as a node package) on current file."
  (interactive)
  (let* ((file (buffer-file-name))
         (temp-file (format "%s_beautify" file)))
    (save-buffer)
    (shell-command (format "beautifier %s > %s" file temp-file))
    (delete-file file)
    (rename-file temp-file file)
    (find-alternate-file file)))

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

(defun y/open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(provide 'init-interactives)
