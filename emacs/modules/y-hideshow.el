(require 'hideshow)

(y:module
 '()
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-c") #'hs-toggle-hiding))

(provide 'y-hideshow)
