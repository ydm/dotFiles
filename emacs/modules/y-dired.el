(y:module
 '((packages ag))

 ;; (require 'dired)
 (define-key dired-mode-map (kbd "/") #'ag))

(provide 'y-dired)
