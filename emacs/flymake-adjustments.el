;; +--------+
;; | JSLint |
;; +--------+
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

;; +--------+
;; | PyLint |
;; +--------+
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

;; Helper for virtual consoles that displays error message at the
;; bottom of the screen

;; TODO: 'cl is needed for caaadr
(require 'cl)
(defun fma-message-errors ()
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
	 (line-err-info-list (nth 0 (flymake-find-err-info
                                     flymake-err-info line-no)))
         (menu-data          (flymake-make-err-menu-data
                              line-no line-err-info-list)))
    (message "%s" (caaadr menu-data))))

(provide 'flymake-adjustments)
