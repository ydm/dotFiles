(require 'cl-seq)

;; +-----------------------+
;; | Directories and files |
;; +-----------------------+

(defun d:locate-top-dominating-file (file name)
  (when-let ((current (locate-dominating-file file name))
             (parent (d:parent-directory current)))
    (or (d:locate-top-dominating-file parent name) current)))

(defun d:normalize-directory (dir)
  (directory-file-name (expand-file-name dir)))

(defun d:parent-directory (dir)
  (file-name-directory (d:normalize-directory dir)))

(defun d:project-root ()
  (d:locate-top-dominating-file default-directory ".git"))

;; +---------+
;; | Editing |
;; +---------+

(defun d:wrap-in (opening closing)
  (if (use-region-p)
      (let ((a (region-beginning))
            (b (region-end)))
        (save-excursion
          (goto-char a)
          (insert-char opening)
          (goto-char (1+ b))
          (insert-char closing))
        (unless (= a (point))
          (goto-char (+ 2 b))))
    (insert-char opening)
    (move-end-of-line 1)
    (insert-char closing)))

;; +-------+
;; | VTerm |
;; +-------+

(defun d:vterm-buffer-p (name)
  "Return t if `name' is the name of a vterm buffer."
  (string-match-p "^\\*vterm\\*\\(<[0-9]+>\\)?$" name))

(defun d:vterm-buffers ()
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (filtered (cl-remove-if-not #'d:vterm-buffer-p buffers))
         (sorted (sort filtered #'string<)))
    sorted))

(defun d:switch-to-another-vterm-buffer (select)
  (let* ((current (buffer-name))
         (buffers (d:vterm-buffers))
         (nextbuf (funcall select buffers current)))
    (when nextbuf
      (switch-to-buffer nextbuf))))

;; +------+
;; | Misc |
;; +------+

(defun d:next-in-list (xs x)
  (let* ((index (cl-position x xs))
         (next (% (1+ index) (length xs))))
    (when index
      (nth next xs))))

(defun d:prev-in-list (xs x)
  (let* ((index (cl-position x xs))
         (num (length xs))
         (prev (1- index))
         (rotated (% (+ num prev) num)))
    (when index
      (nth rotated xs))))

(provide 'd-common)
