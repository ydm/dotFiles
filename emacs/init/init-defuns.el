(defun y:ansi-color-apply-on-buffer (&optional buffer)
  (interactive)
  (with-current-buffer (if buffer buffer (current-buffer))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun y:del-trail-ws-before-save-hook ()
  ;; TODO: add markdown-mode
  (unless (eq major-mode 'fundamental-mode)
    (delete-trailing-whitespace)))

(defun y:mkdir-ff-hook ()
  (let ((dir (directory-file-name (file-name-directory (buffer-file-name)))))
    (unless (file-exists-p dir)
      (make-directory dir)
      (message "Directory created %s" dir))))

(defun y:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun y:string-startswith (str head)
  (and (stringp str)
       (stringp head)
       (string= head
                (substring str 0
                           (min (length str)
                                (length head))))))

(defun y:unwanted-buffers (&optional wanted)
  (unless wanted (setq wanted '("*Django: " "*Messages*" "*scratch*")))
  (defun wantedp (b)
    (or (get-buffer-process b)
        (remove nil
                (mapcar (lambda (p) (string-match p (buffer-name b)))
                        wanted))))
  (remove-if 'wantedp (buffer-list)))

(provide 'init-defuns)
