;; y: This file was copied from http://lapin-bleu.net/riviera/?p=191
;; and modified by me.

(when (load "flymake" t)
  (defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))

      (list "jslint-browser" (list local-file))))

  (setq flymake-err-line-patterns
	(cons '("Error:\\([[:digit:]]+\\):\\([[:digit:]]+\\):\\(.*\\)$"
		nil 1 2 3)
	      flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\'" flymake-jslint-init)))