(defun y:dsp-fix-include-path (dir path)
  (let* ((first (replace-regexp-in-string "\\\\" "/" path))
	 (second (replace-regexp-in-string "/+" "/" first))
	 (third (if (string-prefix-p "." second)
		    (concat (file-name-as-directory dir) second)
		  second)))
    (expand-file-name third)))

(defun y:dsp-read-includes (dsp)
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
  (mapcar (lambda (fn)
	    (y:dsp-fix-include-path (file-name-directory dsp) fn))
	  (y:dsp-read-includes dsp)))

;; (setq dsp "m:/vray4maya/vray4maya.dsp")
;; (y:dsp-read-includes2 dsp)

(provide 'init-dsp)
