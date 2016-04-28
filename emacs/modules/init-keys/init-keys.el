(require 'ido-goto-symbol)
(require 'zap-up-to-char)

;; Dependencies:
;;   ido-goto-symbol.el
;;   (ido-goto-symbol)
;;   zap-up-to-char
;;     (zap-up-to-char)
;;
;; Keys not listed here:
;;   init-dired (local to dired-mode):
;;     / (grep)
;;     ^ (go up)
;;   init-smex:
;;     M-x

;; TODO: Prefix these funcs or move them to init-cmd.el
(defun y:init-keys/open-line ()
  (interactive)
  (move-beginning-of-line nil)
  (open-line 1)
  (indent-for-tab-command))

(defun y:init-keys/wrap-in-double-quotes ()
  (interactive)
  (insert-char ?\")
  (move-end-of-line 1)
  (insert-char ?\"))

(defun y:init-keys/wrap-in-parentheses ()
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
(global-set-key (kbd "C-o")     (function y:init-keys/open-line))
(global-set-key (kbd "C-x C-b") (function bs-show))
(global-set-key (kbd "M-z")     (function zap-up-to-char))

;; Bind built-in commands (re)mapped on user-space keys
(global-set-key (kbd "<f5>")    (function replace-string))
(global-set-key (kbd "S-<f5>")  (function replace-regexp))
(global-set-key (kbd "<f6>")    (function sort-lines))
(global-set-key (kbd "<f11>")   (function whitespace-mode))
(global-set-key (kbd "<f12>")   (function hs-toggle-hiding))
(global-set-key (kbd "C-M-z")   (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z")     (lambda () (interactive) (other-window  1)))
(global-set-key (kbd "s-z")     (function repeat))

;; My own commands mapped on user-space keys
(global-set-key (kbd "C-(")     (function y:init-keys/wrap-in-parentheses))
(global-set-key (kbd "C-\"")    (function y:init-keys/wrap-in-double-quotes))
(global-set-key (kbd "C-c i")   (function ido-goto-symbol))
(global-set-key (kbd "s-n")     (lambda () (interactive) (next-line     5)))
(global-set-key (kbd "s-o")     (function forward-whitespace))
(global-set-key (kbd "s-p")     (lambda () (interactive) (previous-line 5)))

;; Fucking Windows doesn't recognize s-p and s-o, so these two are
;; alternatives.
(global-set-key (kbd "s-m")     (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "s-f")     (function forward-whitespace))

(provide 'init-keys)
