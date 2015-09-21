;; WIP

(require 's)

(defvar *y:gcc* "g++-4.4")

;; g++-4.4 -xc++ -E -v -
(let* ((content (shell-command-to-string (format "%s -print-search-dirs" *y:gcc*)))
       (noheaders (replace-regexp-in-string "^[[:word:]]+: =?" "" content t t))
       (dirs (split-string noheaders "[:\n]"))
       (norm (mapcar #'expand-file-name dirs))
       (delinked (mapcar
		  (lambda (s)
		    (s-replace "\n" ""
			       (shell-command-to-string
				(format "readlink -m \"%s\"" s))))
		  norm))
       (dedup (delete-dups delinked))

       (files (apply #'append
		     (mapcar (lambda (dir)
			       (and (file-directory-p dir)
				    (directory-files dir)))
			     dedup))))
  files)

(provide 'init-gcc)
