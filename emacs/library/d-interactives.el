(use-package d-common :load-path "~/dotFiles/emacs/library")

(defun d:5-next () (interactive) (next-line 5))
(defun d:5-prev () (interactive) (previous-line 5))

;; Original taken from https://superuser.com/questions/601982/ .
(defun d:ido-imenu ()
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

    ;; If there are matching symbols at point, put them at the
    ;; beginning of `symbol-names'.
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

(defun d:keychords/switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun d:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun d:revisit-with-sudo (prefix &optional file)
  "If there is a prefix argument, ask the user for a file to visit.

Without prefix argument:  
- if file is not nil, visit that file
- otherwise revisit current buffer with SUDO."
  (interactive (list
                current-prefix-arg
                (when current-prefix-arg
                  (ido-read-file-name "[SUDO] Find file: "))))
  (defun f (x) (format "/sudo:root@localhost:%s" x))
  (if (or prefix file)
      (find-file (f file))
    (find-alternate-file (f (buffer-file-name)))))

(defun d:wrap-in-angle-braces  () (interactive) (d:wrap-in ?<  ?>  ))
(defun d:wrap-in-curly-braces  () (interactive) (d:wrap-in ?{  ?}  ))
(defun d:wrap-in-double-quotes () (interactive) (d:wrap-in ?\" ?\" ))
(defun d:wrap-in-parenthesis   () (interactive) (d:wrap-in ?\( ?\) ))
(defun d:wrap-in-single-quotes () (interactive) (d:wrap-in ?'  ?'  ))

(provide 'd-interactives)