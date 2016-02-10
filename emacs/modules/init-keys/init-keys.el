(require 'ido-goto-symbol)
(require 'init-zap-up-to-char)

;; Dependencies:
;;   ido-goto-symbol
;;     (ido-goto-symbol)
;;   init-zap-up-to-char
;;     (zap-up-to-char)
;;
;; Keys not listed here:
;;   init-dired (local to dired-mode):
;;     / (grep)
;;     ^ (go up)
;;   init-smex:
;;     M-x

;; TODO: Prefix these funcs or move them to init-cmd.el
(defun y:open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun y:switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun y:wrap-in-double-quotes ()
  (interactive)
  (insert-char ?\")
  (move-end-of-line 1)
  (insert-char ?\"))

(defun y:wrap-in-parentheses ()
  (interactive)
  (insert-char ?()
  (move-end-of-line 1)
  (insert-char ?)))

;; Unset system keys
(global-unset-key (kbd "C-o"))          ; (open-line)
(global-unset-key (kbd "C-x C-b"))      ; (list-buffers)
(global-unset-key (kbd "C-x C-z"))      ; (suspend-frame)
(global-unset-key (kbd "C-x o"))        ; (other-frame)
(global-unset-key (kbd "C-x z"))        ; (repeat)
(global-unset-key (kbd "M-,"))          ; (tags-loop-continue)
(global-unset-key (kbd "M-."))          ; (find-tag)
(global-unset-key (kbd "C-x b"))        ; (ido-switch-buffer)
(global-unset-key (kbd "M-z"))		; (zap-to-char)

;; Reuse system keys
(global-set-key (kbd "C-o")     #'y:open-line)
(global-set-key (kbd "C-x C-b") #'bs-show)
(global-set-key (kbd "M-z")     #'zap-up-to-char)
;; (global-set-key (kbd "M-.")     #'etags-select-find-tag)

;; Bind built-in commands to my own keys
(global-set-key (kbd "<f5>")    #'replace-string)
(global-set-key (kbd "<f6>")    #'sort-lines)
(global-set-key (kbd "<f11>")   #'whitespace-mode)
(global-set-key (kbd "<f12>")   #'hs-toggle-hiding)
(global-set-key (kbd "C-M-z")   (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z")     (lambda () (interactive) (other-window  1)))
(global-set-key (kbd "s-z")     #'repeat)

;; My commands mapped here and there
(global-set-key (kbd "C-(")     #'y:wrap-in-parentheses)
(global-set-key (kbd "C-\"")    #'y:wrap-in-double-quotes)
(global-set-key (kbd "C-c i")   #'ido-goto-symbol)
(global-set-key (kbd "s-n")     (lambda () (interactive) (next-line     5)))
(global-set-key (kbd "s-o")     #'forward-whitespace)
(global-set-key (kbd "s-p")     (lambda () (interactive) (previous-line 5)))

;; Fucking Windows doesn't recognize s-p and s-o, so these two are
;; alternatives.
(global-set-key (kbd "s-m")     (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "s-f")     #'forward-whitespace)

(provide 'init-keys)
