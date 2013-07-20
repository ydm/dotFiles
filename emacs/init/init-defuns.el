(require 'ansi-color)
(require 'cl)

;; Dependencies:
;;   ansi-color:
;;     ansi-color-apply-on-region
;;   cl:
;;     cl-remove-if

(defun y:ansi-color-apply-on-buffer (&optional buffer)
  (interactive)
  (with-current-buffer (if buffer buffer (current-buffer))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun y:delete-trailing-ws-by-mode ()
  (unless (member major-mode '(fundamental-mode markdown-mode))
    (delete-trailing-whitespace)))

(defun y:kill-filename ()
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Killed %s" filename))))

;; http://www.emacswiki.org/emacs/InteractivelyDoThings#toc11
(defun y:ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
                (push (prin1-to-string x t) tag-names))
              tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

(defun y:make-file-dir ()
  (let ((dir (directory-file-name (file-name-directory (buffer-file-name)))))
    (unless (file-exists-p dir)
      (make-directory dir t)
      (message "Directory created %s" dir))))

(defun y:same-owner-p (file)
  (let ((owner (caddr (file-attributes file))))
    (cond ((stringp owner) (string-equal owner (user-login-name)))
          (t (= owner (user-uid))))))

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
  (remove-if #'wantedp (buffer-list)))

(defun y:wrap-in-parentheses ()
  (interactive)
  (insert-char ?()
  (move-end-of-line 1)
  (insert-char ?)))

;; +----------+
;; | Pythonic |
;; +----------+
(defun y:not-python-main-buffer-p (b &optional main-regexp)
  "TODO: Use main-regexp with fallback to main\.py instead of
hard-coding."
  (not (string-match "main\.py" (buffer-name b))))

(defun y:python-main-buffers (&optional main-regexp)
  (cl-remove-if #'y:not-python-main-buffer-p (buffer-list)))

(provide 'init-defuns)
