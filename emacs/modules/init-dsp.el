(require 'cl)

(defun y:dsp-fix-include-path (dir path)
  "Replace backslashes with slashes and truncate multiple slashes
to just one"
  (let* ((first (replace-regexp-in-string "\\\\" "/" path))
	 (second (replace-regexp-in-string "/+" "/" first))
	 (third (if (string-prefix-p "." second)
		    (concat (file-name-as-directory dir) second)
		  second)))
    (expand-file-name third)))

(defun y:dsp-read-includes (dsp)
  "Parse a DSP file and return a list of all the include
directories supplied to the compiler"
  (let ((res))
    (with-temp-buffer
      (insert-file-contents dsp)
      (goto-char (point-min))
      (save-match-data
	(while (re-search-forward "/I \"\\([^\"]+\\)\"" nil t)
	  (let ((f (match-string 1)))
	    (add-to-list 'res f)))))
    res))

(defun y:dsp-read-includes2 (dsp)
  "Does the same as y:dsp-read-includes, but also fixes
filepaths"
  (mapcar (lambda (fn)
	    (y:dsp-fix-include-path (file-name-directory dsp) fn))
	  (y:dsp-read-includes dsp)))

(defun y:dsp-search-parents (start)
  "Searches for a *.dsp file.  works for at most 5 directory
levels above the current buffer's file"
  (interactive)
  (cl-labels ((d (f) (file-name-directory (directory-file-name f))))
    (cl-loop repeat 5
	     for dir = (d start) then (d dir)
	     for dsp = (file-expand-wildcards (concat dir "*.el"))
	     do (if (not (null dsp))
		    (return dsp)))))

;; ydm TODO: Test with (add-hook 'find-file-hook #'y:dsp-on-find-file)
(defun y:dsp-on-find-file ()
  (message "search result: %s" (y:dsp-search-parents (buffer-file-name))))

(provide 'init-dsp)
