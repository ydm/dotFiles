;; +--------------+
;; | Interactives |
;; +--------------+

(require 'cl)
(require 'imenu)

(defun y:block-comment (comment)
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

;; https://superuser.com/questions/601982/
(defun y:ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to
navigate to. Symbols matching the text at point are put first in
the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (cl-labels ((addsymbols
                 (symbol-list)
                 (when (listp symbol-list)
                   (dolist (symbol symbol-list)
                     (let ((name nil) (position nil))
                       (cond
                        ((and (listp symbol) (imenu--subalist-p symbol))
                         (addsymbols symbol))

                        ((listp symbol)
                         (setq name (car symbol))
                         (setq position (cdr symbol)))

                        ((stringp symbol)
                         (setq name symbol)
                         (setq position
                               (get-text-property 1 'org-imenu-marker symbol))))

                       (unless (or (null position) (null name))
                         (add-to-list 'symbol-names name)
                         (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning
    ;; of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols
                (delq nil (mapcar
                           (lambda (symbol)
                             (if (string-match regexp symbol) symbol))
                           symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc
             (lambda (symbol)
               (setq symbol-names (cons symbol (delete symbol symbol-names))))
             matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark)
      (if (overlayp position)
          (goto-char (overlay-start position))
        (goto-char position)))))

(defun y:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun y:push-filename-line ()
  "Push the current buffer's filename:line into the kill ring."
  (interactive)
  (let* ((filename (buffer-file-name))
         (line (line-number-at-pos))
         (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(defun y:replace-last-sexp ()
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

(defun y:revisit-with-sudo (prefix &optional file)
  "If this function gets called without a prefix argument argument:
- and a file: open that file with sudo
- and no file: revisit the current buffer file with sudo

If there is a prefix argument, ask the user for a file to visit."
  (interactive (list
                current-prefix-arg
                (when current-prefix-arg
                  (ido-read-file-name "[SUDO] Find file: "))))
  (defun f (x) (format "/sudo:root@localhost:%s" x))
  (if (or prefix file)
      (find-file (f file))
    (find-alternate-file (f (buffer-file-name)))))

;; (defun y:revisit-with-sudo (prefix &optional file)
;;   (interactive "P\nf")
;;   (let ((x (or file (buffer-file-name))))
;;     (if x
;;         (find-alternate-file (format "/sudo:root@localhost:%s" x))
;;       (user-error "This buffer is not visiting a file"))))

(defun y:wrap-in-parentheses ()
  (interactive)
  (insert-char ?\()
  (move-end-of-line 1)
  (insert-char ?\)))

;; TODO: Write a function that I can bind on C-', C-", C-(, C-{ and
;; whatever else there is that wraps a region in quotes, double
;; quotes, parentheses and whatever else that comes in pairs.

;; +---------+
;; | Helpers |
;; +---------+

(defun y:parent-directory (dir)
  (file-name-directory (directory-file-name dir)))

(defun y:locate-top-dominating-file (file name)
  (when-let ((current (locate-dominating-file file name))
             (parent (y:parent-directory current)))
    (or (y:locate-top-dominating-file parent name) current)))

(defun y:project-root ()
  (y:locate-top-dominating-file default-directory ".git"))

;; +--------+
;; | Module |
;; +--------+

(y:module
 '((packages find-file-in-project))

 (require 'find-file-in-project)        ; -> y:find-file

 (setq ffip-project-root-function #'y:project-root)

 (defun y:find-file (prefix)
   "If there's a project root, use (find-file-in-project).
Otherwise fallback to (ido-find-file)."
   (interactive "P")
   (if (and (null prefix)
            (not (string-equal system-type "windows-nt"))
            (y:project-root))
       (find-file-in-project)
     (ido-find-file)))
 )

(provide 'y-interactive)
