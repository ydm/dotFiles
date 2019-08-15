;; +--------------+
;; | Interactives |
;; +--------------+

(require 'cl)
(require 'imenu)

(defun y:block-comment (comment)
  (interactive "sLabel: ")
  (cl-labels ((insert-commented (str wrapper filling)
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

(defun y:revisit-with-sudo (&optional file)
  (interactive)
  (or file (setq file (buffer-file-name)))
  (if file
      (find-alternate-file (format "/sudo:root@localhost:%s" file))
    (user-error "This buffer is not visiting a file")))

(defun y:wrap-in-parentheses ()
  (interactive)
  (insert-char ?()
               (move-end-of-line 1)
               (insert-char ?)))


;; +--------+
;; | Module |
;; +--------+

(y:module
 '(find-file-in-project)

 (require 'find-file-in-project)         ; -> y:find-file

 (defun y:find-file (prefix)
   "If there's a project root, use (find-file-in-project).
Otherwise fallback to (ido-find-file)."
   (interactive "P")
   (if (and (null prefix) (y:project-root))
       (find-file-in-project)
     (ido-find-file)))

 (defun y:project-root ()
   "Copy of (ffip-project-root), but returns nil if there's no
project root found.  The standard (ffip-project-root) returns
default-directory instead."
   (let* ((project-root (or ffip-project-root
                            (cond
                             ((functionp ffip-project-root-function)
                              (funcall ffip-project-root-function))
                             ((listp ffip-project-file)
                              (ffip--some (apply-partially
                                           #'locate-dominating-file
                                           default-directory)
                                          ffip-project-file))
                             (t
                              (locate-dominating-file default-directory
                                                      ffip-project-file))))))
     project-root))
 )

(provide 'y-interactive)
