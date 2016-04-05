;; Miscellaneous functions and utilities

(defun y:eval-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

(provide 'init-misc)
