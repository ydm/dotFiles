(y:module
 '((packages ag))

 (require 'ag)
 (define-key ag-mode-map (kbd "q")
   (lambda (prefix)
     (interactive "P")
     (if prefix
         (kill-buffer-and-window)
       (kill-buffer))))

 (require 'dired)
 (define-key dired-mode-map (kbd "/") #'ag))

(provide 'y-ag)
