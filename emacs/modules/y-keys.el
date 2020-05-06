;; Here's a table of all my keys defined in OTHER files and where
;; exactly
;;
;; |-----+-----------------+---------|
;; | key | map             | file    |
;; |-----+-----------------+---------|
;; | "/" | vc-dir-mode-map | y-vc.el |
;; | "/" | dired-mode-map  | y-ag.el |
;; | "q" | ag-mode-map     | y-ag.el |
;; |-----+-----------------+---------|


(y:module
 '((packages smex))

 ;; (defun y:my-scroll-up-command ()
 ;;   (interactive)
 ;;   (mwheel-scroll 'mouse-5))
 ;; (defun y:my-scroll-down-command ()
 ;;   (interactive)
 ;;   (mwheel-scroll 'mouse-4))

 (require 'y-interactive)
 (require 'y-window)

 ;; Unset system keys
 (global-unset-key (kbd "C-<delete>"))   ; kill-word
 (global-unset-key (kbd "C-<insert>"))   ; kill-ring-save
 (global-unset-key (kbd "C-o"))          ; open-line
 (global-unset-key (kbd "C-x C-b"))      ; list-buffers
 (global-unset-key (kbd "C-x C-f"))      ; find-file
 (global-unset-key (kbd "C-x C-r"))      ; find-file-read-only
 (global-unset-key (kbd "C-x o"))        ; other-frame
 (global-unset-key (kbd "C-z"))          ; suspend-frame
 (global-unset-key (kbd "M-x"))          ; execute-extend-command
 ;; (global-unset-key (kbd "C-v"))          ; scroll-up-command
 ;; (global-unset-key (kbd "M-v"))          ; scroll-down-command

 ;; Reuse system keys
 (global-set-key (kbd "C-<delete>")      #'window-swap-states)
 (global-set-key (kbd "C-<insert>")      #'y:restore-windows)
 (global-set-key (kbd "C-o")             #'y:open-line)
 (global-set-key (kbd "C-x C-b")         #'bs-show)
 (global-set-key (kbd "C-x C-f")         #'y:find-file)
 (global-set-key (kbd "C-x C-r")         #'y:revisit-with-sudo)
 (global-set-key (kbd "M-x")             #'smex)
 ;; (global-set-key (kbd "C-v")             #'y:my-scroll-up-command)
 ;; (global-set-key (kbd "M-v")             #'y:my-scroll-down-command)

 ;; New keys
 (define-key prog-mode-map (kbd "C-c i") #'y:ido-imenu)
 (global-set-key (kbd "<f13>")           #'smex)
 (global-set-key (kbd "C-(")             #'y:wrap-in-parentheses)
 (global-set-key (kbd "s-o")             #'forward-whitespace))

(provide 'y-keys)
