;; Works for gcc or gcc compatible compilers like clang

(defvar *y:gcc* "clang")  ;; or gcc-4.4, clang, etc.

(defun y:gcc-system-include-dirs (&optional compiler)
  "Return compiler's default system include directories"
  (let* ((compiler (or compiler *y:gcc*))
	 (cmd (format"
[ -z $CC ] && CC=%s ;
for f in $($CC -xc++ -E -v 2>&1 - </dev/null | grep -e \"^ /\" | grep -e include) ;
do
readlink -f $f;
done" compiler)))
  (split-string (shell-command-to-string cmd))))

(provide 'init-gcc)
