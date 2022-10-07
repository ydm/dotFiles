;; -*- lexical-binding: t; -*-

;; (y:module
;;  '((packages markdown-mode nim-mode))

;;  (require 'cl)
;;  (require 'markdown-mode)
;;  (require 'nim-mode)

;;  (defun d:nim-make-ag-command (sym root &optional private single-line)
;;    (let ((fmt (if single-line
;;                   "rg --vimgrep --smart-case -e '^(type)?\\s*\\b%s%s(\\[[:;\\[\\]\\s\\w]+\\])?\\s*(\\{\\.[\\s\\w,]*\\.\\}\\s*)?=' '%s'"
;;                 "rg --vimgrep --smart-case -e '^(type)?\\s+\\b%s%s' '%s'"))
;;          (star (if private "" "\\*")))
;;      (format fmt sym star root)))

;;  (defun d:nim-find-definition-location (symbol root &optional private single-line)
;;    "Dependencies: cl-remove-if markdown-trim-whitespace"
;;    (when-let* ((cmd (d:nim-make-ag-command symbol root private single-line))
;;                (out (shell-command-to-string cmd))
;;                (lines (split-string out "\n"))
;;                (trimmed (mapcar #'markdown-trim-whitespace lines))
;;                (checked (cl-remove-if (lambda (xs) (zerop (length xs))) trimmed))
;;                (chosen (car trimmed))
;;                (vimgrep (first (split-string chosen)))
;;                (parts (split-string vimgrep ":"))
;;                (filename (car parts))
;;                (line (string-to-number (cadr parts)))
;;                (column (string-to-number (caddr parts))))
;;      (message
;;       "d:nim-find-definition-location: private=%s single-line=%s result=%s:%s:%s cmd=%s"
;;       private
;;       single-line
;;       filename line column
;;       cmd)
;;      (list filename line column)))

;;  (defun d:nim-goto (xs)
;;    (let ((filename (car xs))
;;          (line (cadr xs))
;;          (column (caddr xs)))
;;      (when (and filename line column)
;;        (find-file filename)
;;        (goto-char
;;         (save-mark-and-excursion
;;           (goto-line line)
;;           (goto-char (1- (+ (point) column)))
;;           ;; Because of ^\s* we might be positioned at the beggining
;;           ;; of the line.  (back-to-indentation) is a safe fallback.
;;           (back-to-indentation)
;;           (point))))))

;;  (defun d:nim-find-definition ()
;;    "Dependencies: cl-remove-if markdown-trim-whitespace"
;;    (interactive)
;;    (when-let ((symbol (thing-at-point 'symbol)))
;;      (cl-block outer
;;        (cl-loop for single-line in '(t nil) do
;;                 (cl-loop for dir in (d:parent-directories default-directory) do
;;                          (when-let (loc (or (d:nim-find-definition-location symbol dir nil single-line)
;;                                             (d:nim-find-definition-location symbol dir t single-line)))
;;                            (cl-return-from outer (d:nim-goto loc))))))))

;;  (define-key nim-mode-map (kbd "C-.") #'d:nim-find-definition))

(provide 'd-nim)
