(y:module
 '((packages smex))

 (require 'y-interactive)

 ;; Unset system keys
 (global-unset-key (kbd "C-o"))          ; open-line
 (global-unset-key (kbd "C-x C-b"))      ; list-buffers
 (global-unset-key (kbd "C-x C-f"))      ; find-file
 (global-unset-key (kbd "C-x o"))        ; other-frame
 (global-unset-key (kbd "C-z"))          ; suspend-frame
 (global-unset-key (kbd "M-x"))          ; execute-extend-command
 (global-unset-key (kbd "C-x C-r"))      ; find-file-read-only

 ;; Reuse system keys
 (global-set-key (kbd "C-o")             #'y:open-line)
 (global-set-key (kbd "C-x C-b")         #'bs-show)
 (global-set-key (kbd "C-x C-f")         #'y:find-file)
 (global-set-key (kbd "C-x C-r")         #'y:revisit-with-sudo)
 (global-set-key (kbd "M-x")             #'smex)

 ;; New keys
 (define-key prog-mode-map (kbd "C-(")   #'y:wrap-in-parentheses)
 (define-key prog-mode-map (kbd "C-c i") #'y:ido-imenu)
 (define-key prog-mode-map (kbd "s-o")   #'forward-whitespace)
 (global-set-key (kbd "<f13>")           #'smex)

 )

(provide 'y-keys)
