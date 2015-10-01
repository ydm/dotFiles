(defvar *y:cc* "gcc")  ;; or gcc-4.4, clang, etc.

(defun y:gcc-system-include-dirs (&optional compiler)
  "Return compiler's default system include directories"
  (let ((compiler (or compiler *y:cc*))
	(fmt "
[ -z $CC ] && CC=%s ;
for f in $($CC -xc++ -E -v 2>&1 - </dev/null | grep -e \"^ /\" | grep -e include) ;
do
  readlink -f $f;
done"))
  (split-string (shell-command-to-string (format fmt compiler)))))

(provide 'init-gcc)
