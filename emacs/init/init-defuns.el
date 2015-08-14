(require 'cl)
(require 'dired)

;; Dependencies:
;;   cl:
;;     (cl-remove-if)
;;   dired:
;;     dired-mode-map

(defun y:delete-trailing-ws-by-mode ()
  "Delete trailing white space unless current major mode is
fundamental-mode."
  (unless (member major-mode '(fundamental-mode))
    (delete-trailing-whitespace)))

(defun y:insert-block-delimiter (title)
  (let ((fixed (if (< 0 (length title)) (format "%s " title) "")))
    (insert (format "# %s" fixed))
    (loop for _ below (- 75 (length fixed))
          do (insert ?-))
    (insert " #\n")))

(defun y:reuse-dired-buffer-on-up ()
  (define-key dired-mode-map (kbd "^")
    (lambda ()
      (interactive)
      (find-alternate-file ".."))))

(defun y:string-startswith (str head)
  (and (stringp str)
       (stringp head)
       (string= head
                (substring str 0
                           (min (length str)
                                (length head))))))

(defun y:system-buffers (&optional wanted)
  "Return a list of all buffers that are not bound to a process and are
different than WANTED (defaults to messages, packages and scratch)"
  (unless wanted (setq wanted '("*Messages*" "*Packages*" "*scratch*")))
  (defun wantedp (b)
    (or (get-buffer-process b)
        (remove nil
                (mapcar (lambda (p) (string-match p (buffer-name b)))
                        wanted))))
  (cl-remove-if #'wantedp (buffer-list)))


(provide 'init-defuns)
