;; TODO
(defvar *ntags-root* "")
(defvar *ntags-table* nil)

(defun ntags-table-put (name dest regexp)
  (let ((stored (gethash name *ntags-table*))
        (value (list dest regexp)))
    (if stored
        (puthash name (cons value stored) *ntags-table*)
      (puthash name (list value) *ntags-table*))))

(defun ntags-read-lines (path)
  (with-temp-buffer
    (insert-file-contents path)
    (split-string (buffer-string) "\n" t)))

(defun ntags-visit-tags-table (path)
  (setq path (expand-file-name path))

  ;; Adjust global variables.  TODO: Should/can I make this
  ;; buffer-local?
  (setq *ntags-root* (file-name-directory path))
  (setq *ntags-table* (make-hash-table :test #'equal))

  (defun ntags-process-line (line)
    (unless (string-prefix-p "!_TAG_FILE_" line)
      (let* ((parts (split-string line "\t"))
             (name (car parts))
             (dest (cadr parts))
             (regx (caddr parts))
             (tokt (cadddr parts)))
        (ntags-state-put name dest regx))))

  (mapcar #'ntags-process-line (ntags-read-lines path)))

(provide 'ntags)
