;; Miscellaneous functions and utilities

(defun y:cppfilt ()
  (interactive)
  (let* ((symbol (symbol-at-point))
         (cmd    (format "c++filt \"%s\"" symbol))
         (output (shell-command-to-string cmd)))
    (message output)))

(defun y:eval-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

(provide 'init-misc)
