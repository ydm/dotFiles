(require 'hideshow)
(require 'ido-goto-symbol)
(require 'zap-up-to-char)

(require 'init-misc)

;; Dependencies:
;;   ido-goto-symbol.el
;;     (ido-goto-symbol)
;;   zap-up-to-char
;;     (zap-up-to-char)
;;   init-misc
;;     (y:locate-breakpoint)
;;
;; Keys not listed here:
;;   init-dired (local to dired-mode):
;;     / (grep)
;;     ^ (go up)
;;   init-rtags (globals):
;;     C-c r ; -- rtags-find-file
;;   init-smex (globals):
;;     M-x
;;     F13 (which is then remapped to my right Shift)


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
(global-set-key (kbd "C-o")     #'y:init-keys/open-line)
(global-set-key (kbd "C-x C-b") #'bs-show)
(global-set-key (kbd "M-z")     #'zap-up-to-char)

;; Built-in commands (re)mapped on user-space keys
(global-set-key (kbd "<f5>")    #'replace-string)
(global-set-key (kbd "S-<f5>")  #'replace-regexp)
(global-set-key (kbd "<f6>")    #'sort-lines)
(global-set-key (kbd "<f8>")    #'y:locate-breakpoint)
(global-set-key (kbd "<f11>")   #'whitespace-mode)
(global-set-key (kbd "<f12>")   #'hs-toggle-hiding)
(global-set-key (kbd "C-M-z")   (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z")     (lambda () (interactive) (other-window  1)))
(global-set-key (kbd "s-z")     #'repeat)

;; My own commands mapped on user-space keys
(global-set-key (kbd "C-(")     #'y:init-keys/wrap-in-parentheses)
(global-set-key (kbd "C-\"")    #'y:init-keys/wrap-in-double-quotes)
(global-set-key (kbd "C-c i")   #'ido-goto-symbol)
(global-set-key (kbd "s-n")     (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "s-o")     #'forward-whitespace)
(global-set-key (kbd "s-p")     (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "s-m")     (lambda () (interactive) (previous-line 5)))

;; Fucking Windows doesn't recognize s-p and s-o, so these two Windows
;; are alternatives.
;; (global-set-key (kbd "s-m")     (lambda () (interactive) (previous-line 5)))
;; (global-set-key (kbd "s-f")     (function forward-whitespace))

;; Local keys
(define-key hs-minor-mode-map (kbd "C-c C-2 C-a") #'hs-hide-all)
(define-key hs-minor-mode-map (kbd "C-c C-2 C-c") #'hs-toggle-hiding)
(define-key hs-minor-mode-map (kbd "C-c C-2 C-h") #'hs-hide-block)
(define-key hs-minor-mode-map (kbd "C-c C-2 C-s") #'hs-show-block)

(provide 'init-keys)
