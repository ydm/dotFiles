;; Miscellaneous functions and utilities

(defun y:eval-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))


(defun y:gcc-system-include-dirs (&optional compiler)
  "Return compiler's default system include directories"
  (let* ((compiler (or compiler "gcc"))
	 (cmd (format"
[ -z $CC ] && CC=%s ;
for f in $($CC -xc++ -E -v 2>&1 - </dev/null | grep -e \"^ /\" | grep -e include) ;
do
readlink -f $f;
done" compiler)))
  (split-string (shell-command-to-string cmd))))


(provide 'init-misc)
