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

(provide 'd-common)
