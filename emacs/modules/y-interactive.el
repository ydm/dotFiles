(require 'cl)                           ; y:ido-imenu
(require 'imenu)                        ; y:ido-imenu

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


;; Depends on the cl and imenu packages
;; https://superuser.com/questions/601982/
(defun y:ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to
navigate to. Symbols matching the text at point are put first in
the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (cl-flet ((addsymbols
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

(defun y:push-filename-line ()
  "Push the current buffer's filename:line into the kill ring."
  (interactive)
  (let* ((filename (buffer-file-name))
         (line (line-number-at-pos))
         (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(provide 'y-interactive)