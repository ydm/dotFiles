(require 'cl)

(defun y:dsp-fix-include-path (dir path)
  "Replaces backslashes with slashes and truncates multiple
slashes to just one.  Also applies Chaos specific stuff:
- replaces [kK]:\ with proper SDK path
- replaces maya70 with maya2016"
  (let* ((first (replace-regexp-in-string "\\\\" "/" path))
	 (second (if (string-prefix-p "k:/" (downcase (substring first 3)))
		     (concat "~/cgrepo/sdk/linux/" (substring first 3))
		   first))
	 (third (replace-regexp-in-string "/+" "/" second))
	 (fourth (if (string-prefix-p "." third)
		     (concat (file-name-as-directory dir) second)
		   third))
	 (fifth (replace-regexp-in-string "maya70" "maya2016" fourth))
	 (fixed (expand-file-name fifth)))
    fixed))

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
  "Does the same as y:dsp-read-includes, but also checks the DSP
argument and fixes filepaths"
  (if (null dsp)
      '()
    (mapcar (lambda (fn)
	      (let ((path (y:dsp-fix-include-path (file-name-directory dsp) fn)))
		(unless (file-directory-p path)
		  (message "Include directory %s doesn't exist" path))))
	    (y:dsp-read-includes dsp))))

(defun y:dsp-search-parents (start)
  "Searches for a *.dsp file.  Works for at most 7 directory
levels above the current buffer's file"
  (interactive)
  (cl-labels ((d (f) (file-name-directory (directory-file-name f))))
    (cl-loop repeat 7
	     for dir = (d start) then (d dir)
	     for dsp = (file-expand-wildcards (concat dir "*.dsp"))
	     do (if (not (null dsp))
		    (return (car dsp))))))

(defun y:dsp-parse-includes-for-file (&optional file)
  (let* ((file (or file (buffer-file-name)))
	 (dsp (y:dsp-search-parents file))
	 (dirs (y:dsp-read-includes2 dsp)))
    (message "Parsing DSP for include directories: dsp=%s, #dirs=%d"
	     dsp (length dirs))
    dirs))

(provide 'init-dsp)
