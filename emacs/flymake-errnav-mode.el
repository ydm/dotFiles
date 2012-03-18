;; y: This file was copied from http://www.emacswiki.org/emacs/FlyMake .
(defvar flymake-errnav-mode
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-<home>") 'flymake-goto-prev-error)
    (define-key map (kbd "C-<end>" ) 'flymake-goto-next-error)
    map)
  "Keymap for my flymake minor mode.")

(defun flymake-err-at (pos)
  (let ((overlays (overlays-at pos)))
    (remove nil
            (mapcar (lambda (overlay)
                      (and (overlay-get overlay 'flymake-overlay)
                           (overlay-get overlay 'help-echo)))
                    overlays))))

(defun flymake-err-echo ()
  (message "%s" (mapconcat 'identity (flymake-err-at (point)) "\n")))

(defadvice flymake-goto-next-error (after display-message activate compile)
  (flymake-err-echo))

(defadvice flymake-goto-prev-error (after display-message activate compile)
  (flymake-err-echo))

(define-minor-mode flymake-errnav-mode
  "Simple minor mode which adds some key bindings for moving to the
next and previous errors. See flymake-errnav-mode for key binding
information"
  nil nil :keymap flymake-errnav-mode)
