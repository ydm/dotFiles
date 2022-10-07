(setq *d:modules-directory* (file-name-directory load-file-name))

(defun d:join-paths (&rest paths)
  (let ((head (car paths))
        (tail (cdr paths)))
    (if tail
        (concat (file-name-as-directory head) (apply #'d:join-paths tail))
      head)))

(defun d:module-path (&rest paths)
  (let ((args (cons *d:modules-directory* paths)))
    (apply #'d:join-paths args)))

(defun d:load-library (name)
  (let* ((file-name (format "%s.el" name))
         (path (d:module-path "library" file-name))
         (symbol (intern (format "d-library-%s" name))))
    (require symbol path)))

(defun d:load-vendor (symbol &optional file-name)
  (setq file-name (or file-name (format "%s.el" symbol)))
  (let ((path (d:module-path "vendor" file-name)))
    (require symbol path)))

(provide 'd-bootstrap)
