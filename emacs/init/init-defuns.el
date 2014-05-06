(require 'ansi-color)
(require 'cl)

;; Dependencies:
;;   ansi-color:
;;     (ansi-color-apply-on-region)
;;   cl:
;;     (cl-remove-if)

(defun y:ansi-color-apply-on-buffer (&optional buffer)
  (interactive)
  (with-current-buffer (if buffer buffer (current-buffer))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun y:delete-trailing-ws-by-mode ()
  "Delete trailing white space unless current major mode is
fundamental-mode."
  (unless (member major-mode '(fundamental-mode))
    (delete-trailing-whitespace)))

(defun y:get-buffer (buffer-or-name)
  (if buffer-or-name
      (get-buffer buffer-or-name)
    nil))

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

(defun y:mkdir-for-buffer-file-name ()
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

(defun y:string-strip (str)
  "http://is.gd/o1yX0V"
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'" str)
    (setq str (replace-match "" t t str)))
  str)

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
  "Use main-regexp with fallback to main\.py to match the main
buffer."
  (not (string-match (or main-regexp "^main\.py") (buffer-name b))))

(defun y:python-main-buffers (&optional main-regexp)
  (cl-remove-if (lambda (b)
                  (y:not-python-main-buffer-p b main-regexp))
                (buffer-list)))

(provide 'init-defuns)

;; +-----------+
;; | Undertime |
;; +-----------+
;; These are few simple interactive commands I use to track my working time
(defun ut:is-time-string (time-string)
  (integerp (string-match
             "^[+-]?[[:digit:]]\\{2\\}:[[:digit:]]\\{2\\}$" time-string)))

(defun ut:current-line (&optional relative)
  (save-excursion
    (next-line (or relative 0))
    (let* ((start (line-beginning-position))
           (end (line-end-position)))
      (buffer-substring-no-properties start end))))

(defun ut:minute-value (hours minutes)
  (+ (* 60 (abs hours))
     (abs minutes)))

(defun ut:time-to-minutes (time)
  (if (ut:is-time-string time)
      (let* ((sign (if (integerp (string-match "^-" time)) -1 1))
             (parts (split-string time ":"))
             (hours (string-to-number (car parts)))
             (minutes (string-to-number (cadr parts))))
        (message (format "time=%s hours=%d minutes=%d" time hours minutes))
        (* sign (ut:minute-value hours minutes)))
    0))

(defun ut:minutes-to-time (minutes)
  (format "%s%02d:%02d"
          (if (> 0 minutes) "-" " ")
          (abs (/ minutes 60))
          (abs (% minutes 60))))

(defun ut:process-line ()
  (interactive)
  (let* ((previous (ut:current-line -1))
         (weektotal (ut:time-to-minutes (car (last (split-string previous)))))
         (line (ut:current-line))
         (parts (split-string line))
         (arv (ut:time-to-minutes (cadr parts)))
         (dpt (ut:time-to-minutes (caddr parts)))
         (total (- dpt arv))
         (balance (- total (ut:minute-value 8 30)))
         (weekbalance (+ weektotal balance)))
    (save-excursion
      (end-of-line)
      (insert (format " %6s %6s %6s"
                      (ut:minutes-to-time total)
                      (ut:minutes-to-time balance)
                      (ut:minutes-to-time weekbalance))))))

;; #     Date   Arv   Dpt  Total Balnce WBalnc
;; 02/12/2013 09:50 19:50  10:00  01:30  01:30
;; 03/12/2013 10:45 17:00
;; 04/12/2013 10:40 19:00
;; 05/12/2013 09:25 17:00
;; 06/12/2013 10:00 17:00
;; Delete the ";; " at start and invoke (ut:process-line)

(defun ut:header ()
  (interactive)
  (insert "#     Date   Arv   Dpt  Total Balnce MBalnc\n"))

;; TODO: Set time to -1 minute from now
(defun ut:arrive ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (insert (format-time-string "%d-%m-%Y %H:%M"))))

;; TODO: Set time to +1 minute from now ;)
(defun ut:depart ()
  (interactive)
  (save-excursion
    (end-of-line)
    (insert (format-time-string " %H:%M")))
  (ut:process-line))
