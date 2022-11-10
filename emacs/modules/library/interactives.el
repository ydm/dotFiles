;; +--------------+
;; | Interactives |
;; +--------------+

(require 'cl)
(require 'imenu)


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


;; Original taken from https://superuser.com/questions/601982/
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


(defun d:neotree-toggle ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((root (d:project-root))
          (file (buffer-file-name)))
      (neotree-toggle)
      (when (neo-global--window-exists-p)
        (if root (neotree-dir root))
        (if file (neotree-find file)))))


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


(defun d:terminal (&optional prefix)
  (interactive "P")
  (if (not (fboundp 'vterm-toggle))
      (shell)
    (and (fboundp 'vterm-toggle)
         (vterm-toggle)
         prefix
         (let* ((root (d:project-root))
                (expanded (expand-file-name root))
                (cmd (format "cd '%s'" expanded)))
           (vterm-send-string cmd t)
           (vterm-send-return)))))


(defun d:toggle-window-split ()
  "https://github.com/magnars/.emacs.d/ ... /defuns/buffer-defuns.el#L42"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))


(defun d:wrap-in (opening closing)
  (interactive)
  (if (use-region-p)
      (let ((a (region-beginning))
            (b (region-end)))
        (save-excursion
          (goto-char a)
          (insert-char opening)
          (goto-char (1+ b))
          (insert-char closing))
        (unless (= a (point))
          (goto-char (+ 2 b))))
    (insert-char opening)
    (move-end-of-line 1)
    (insert-char closing)))


(defun d:wrap-in-curly-braces  () (interactive) (d:wrap-in ?{  ?}  ))
(defun d:wrap-in-double-quotes () (interactive) (d:wrap-in ?\" ?\" ))
(defun d:wrap-in-parenthesis   () (interactive) (d:wrap-in ?\( ?\) ))
(defun d:wrap-in-single-quotes () (interactive) (d:wrap-in ?'  ?'  ))


;; +---------+
;; | Helpers |
;; +---------+

(defun d:normalize-directory (dir)
  (directory-file-name (expand-file-name dir)))

(defun d:parent-directories (dir)
  (let* ((norm (d:normalize-directory dir))
         (parent (d:parent-directory norm)))
    (if (string-equal norm parent)
        '()
      (cons norm (d:parent-directories parent)))))


(defun d:parent-directory (dir)
  (file-name-directory (d:normalize-directory dir)))


(defun d:project-root ()
  (d:locate-top-dominating-file default-directory ".git"))


(defun d:locate-top-dominating-file (file name)
  (when-let ((current (locate-dominating-file file name))
             (parent (d:parent-directory current)))
    (or (d:locate-top-dominating-file parent name) current)))





;; +---------+
;; | Project |
;; +---------+

;; It's guaranteed to have available all packages that are described
;; as (d:module) dependencies.
(require 'projectile)


(defun d:find-file (&optional prefix)
  (interactive "P")
  (if (and (null prefix)
           (not (string-equal system-type "windows-nt"))
           (d:project-root))
      ;; Use projectile, but use the top workspace directory, not just
      ;; this submodule.
      (let ((buffer (current-buffer))
            (prev default-directory)
            (root (d:project-root)))
        (cd root)
        (projectile-find-file)
        (with-current-buffer buffer
          (cd prev)))
    (ido-find-file)))


(provide 'd-library-interactives)
