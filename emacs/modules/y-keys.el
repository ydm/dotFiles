(y:module
 '(find-file-in-project smex)

 (require 'find-file-in-project)         ; find-file-in-project
 (require 'y-interactive)                ; y:ido-imenu
 (require 'y-lib)                        ; y:project-root

 (defun y:find-file (prefix)
   "If there's a project root, use (find-file-in-project).
Otherwise fallback to (ido-find-file)."
   (interactive "P")
   (if (and (null prefix) (y:project-root))
       (find-file-in-project)
     (ido-find-file)))

 (defun y:keys/open-line ()
   (interactive)
   (move-beginning-of-line nil)
   (open-line 1)
   (indent-for-tab-command))

 ;; Unset system keys
 (global-unset-key (kbd "C-o"))         ; open-line
 (global-unset-key (kbd "C-x C-b"))     ; list-buffers
 (global-unset-key (kbd "C-x C-f"))     ; find-file
 (global-unset-key (kbd "C-x o"))       ; other-frame
 (global-unset-key (kbd "C-z"))         ; suspend-frame
 (global-unset-key (kbd "M-x"))         ; execute-extend-command

 ;; Reuse system keys
 (global-set-key (kbd "C-o")     #'y:keys/open-line)
 (global-set-key (kbd "C-x C-b") #'bs-show)
 (global-set-key (kbd "C-x C-f") #'y:find-file)
 (global-set-key (kbd "M-x")     #'smex)

 ;; New global keys
 (global-set-key (kbd "<f13>")   #'smex)
 (global-set-key (kbd "C-c i")   #'y:ido-imenu)
 (global-set-key (kbd "s-o")     #'forward-whitespace))

(provide 'y-keys)
