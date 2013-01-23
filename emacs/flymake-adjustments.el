(when (load "flymake")
  (defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "jslint" (list local-file))))

  ;; TODO
  (add-to-list 'flymake-err-line-patterns
	       '("Error:\\([[:digit:]]+\\):\\([[:digit:]]+\\):\\(.*\\)$" nil 1 2 3))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\'" flymake-jslint-init)))

(when (load "flymake")
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(provide 'flymake-adjustments)
