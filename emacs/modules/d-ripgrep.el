(y:module
 '((packages ripgrep))

 (require 'ripgrep)
 (require 'dired)

 (define-key dired-mode-map (kbd "/")
   (lambda (needle)
     (interactive "sSearch for: ")
     (ripgrep-regexp needle default-directory))))

(provide 'd-ripgrep)
