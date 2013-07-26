(autoload 'pos-tip-show "pos-tip")

(defun errnav-get-errors ()
  (defun filter (o)
    (and (overlay-get o 'flymake-overlay) (overlay-get o 'help-echo)))
  (remove nil (mapcar 'filter (overlays-at (point)))))

(defun errnav-display-errors ()
  (interactive)
  (let ((e (mapconcat 'identity (errnav-get-errors) "\n")))
    ;; (pos-tip-show e '("white" . "#5f2737"))
    ;; (pos-tip-show e '("black" . "#503450"))
    ;; (pos-tip-show e '("black" . "#d17515"))
    (pos-tip-show e)
    ))

(defadvice flymake-goto-next-error (after errnav-next-advice activate compile)
  (errnav-display-errors))

(defadvice flymake-goto-prev-error (after errnav-prev-advice activate compile)
  (errnav-display-errors))

(defvar errnav-mode-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-<home>") 'flymake-goto-prev-error)
    (define-key map (kbd "C-<end>" ) 'flymake-goto-next-error)
    map))

(define-minor-mode errnav-minor-mode
  "Simple minor mode that adds the following key bindings for
moving to the next and previous flymake errors:

C-<home> Go to previous error.
C-<end> Go to next error."
  :keymap errnav-mode-keymap)

(provide 'errnav-minor-mode)
