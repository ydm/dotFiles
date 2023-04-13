(require 'cl-macs)                      ; cl-flet cl-labels
(require 'imenu)

(use-package ripgrep :commands ripgrep-regexp :demand :ensure t)
(use-package d-common :load-path "~/dotFiles/emacs/library")

(defun d:5-next () (interactive) (next-line 5))
(defun d:5-prev () (interactive) (previous-line 5))

(defun d:block-comment (comment)
  (interactive "sLabel: ")
  (cl-flet ((insert-commented (str wrapper filling)
                              (indent-according-to-mode)
                              (insert (comment-padright comment-start
                                                        (comment-add nil)))
                              (insert-char wrapper)
                              (insert-char filling)
                              (insert str)
                              (insert-char filling)
                              (insert-char wrapper)
                              (insert-char ?\n)))
    (let ((rule (make-string (length comment) ?-)))
      (save-excursion
        (insert-commented rule ?+ ?-)
        (insert-commented comment ?| ? )
        (insert-commented rule ?+ ?-)))))

(defun d:copy-filename ()
  "Copy filename:line to clipbord."
  (interactive)
  (let* ((filename (buffer-file-name))
         (line (line-number-at-pos))
         (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(defun d:keychords/switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun d:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun d:replace-last-sexp ()
  "Evaluates the last sexp before point and replaces it with the
result it yields.  This function uses something similar
to (backward-kill-sexp), but *deletes* the sexp instead of
*killing* it"
  (interactive)
  (let ((value (eval-last-sexp nil))
        (opoint (point)))
    (forward-sexp -1)
    (delete-region opoint (point))
    (insert (format "%s" value))))

(defun d:revisit-with-sudo (prefix &optional file)
  "If there is a prefix argument, ask the user for a file to
visit.  Otherwise either visit the `file' given as an argument or
revisit the one, associated with the current buffer."
  (interactive (list
                current-prefix-arg
                (when current-prefix-arg
                  (ido-read-file-name "[SUDO] Find file: "))))
  (defun f (x) (format "/sudo:root@localhost:%s" x))
  (if (or prefix file)
      (find-file (f file))
    (find-alternate-file (f (buffer-file-name)))))

(defun d:ripgrep (needle)
  (interactive "sGrep for: ")
  (ripgrep-regexp needle default-directory))

(defun d:wrap-in-angle-braces  () (interactive) (d:wrap-in ?<  ?>  ))
(defun d:wrap-in-curly-braces  () (interactive) (d:wrap-in ?{  ?}  ))
(defun d:wrap-in-double-quotes () (interactive) (d:wrap-in ?\" ?\" ))
(defun d:wrap-in-parenthesis   () (interactive) (d:wrap-in ?\( ?\) ))
(defun d:wrap-in-single-quotes () (interactive) (d:wrap-in ?'  ?'  ))

(provide 'd-interactives)
