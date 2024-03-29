;; -*- lexical-binding: t; -*-


;; +--------------------------------------+
;; |     Keys defined in OTHER files      |
;; +-----+-----------------+--------------+
;; | key | map             | file         |
;; |-----+-----------------+--------------|
;; | "/" | vc-dir-mode-map | d-vc.el      |
;; | "/" | dired-mode-map  | d-ripgrep.el |
;; +-----+-----------------+--------------+

(d:module
 '((packages smex))

 (require 'd-bootstrap)
 (d:load-library 'interactives)
 (d:load-library 'windows)

 ;; Unset system keys
 ;;
 ;; TODO: See share/emacs/28.1/lisp/ido.el.gz:1567
 ;;       and use [remap cmd]
 ;;       e.g. (define-key map [remap find-file] 'ido-find-file)
 ;;
 (global-unset-key (kbd "C-<delete>"))   ; kill-word
 (global-unset-key (kbd "C-<insert>"))   ; kill-ring-save
 (global-unset-key (kbd "C-o"))          ; open-line
 (global-unset-key (kbd "C-x C-b"))      ; list-buffers
 (global-unset-key (kbd "C-x C-r"))      ; find-file-read-only
 (global-unset-key (kbd "C-x o"))        ; other-frame
 (global-unset-key (kbd "C-z"))          ; suspend-frame
 (global-unset-key (kbd "M-x"))          ; execute-extend-command
 (global-unset-key (kbd "M-z"))          ; zap-to-char
 (global-unset-key (kbd "C-x C-f"))      ; find-file

 ;; Reuse system keys
 (global-set-key (kbd "C-<delete>")      #'window-swap-states)
 (global-set-key (kbd "C-<insert>")      #'d:restore-windows)
 (global-set-key (kbd "C-o")             #'d:open-line)
 (global-set-key (kbd "C-x C-b")         #'bs-show)
 (global-set-key (kbd "C-x C-r")         #'d:revisit-with-sudo)
 (global-set-key (kbd "M-z")             #'zap-up-to-char)
 (global-set-key (kbd "M-x")             #'smex)
 (global-set-key (kbd "C-x C-f")         #'d:find-file)

 ;; New global keys
 (define-key prog-mode-map (kbd "C-c i") #'d:ido-imenu)
 (global-set-key (kbd "<f13>")           #'smex)
 (global-set-key (kbd "C-'")             #'d:wrap-in-single-quotes)
 (global-set-key (kbd "C-(")             #'d:wrap-in-parenthesis)
 (global-set-key (kbd "C-<")             #'d:wrap-in-angle-braces)
 (global-set-key (kbd "C-\"")            #'d:wrap-in-double-quotes)
 (global-set-key (kbd "C-{")             #'d:wrap-in-curly-braces)
 (global-set-key (kbd "C-`")             #'d:terminal)
 (global-set-key (kbd "M-n")             (lambda () (interactive) (next-line 5)))
 (global-set-key (kbd "M-p")             (lambda () (interactive) (previous-line 5)))
 (global-set-key (kbd "s-o")             #'forward-whitespace))


(provide 'd-keys)
