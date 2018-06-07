(y:module
 '(rust-mode racer)
 (add-hook 'rust-mode-hook #'racer-mode)
 (add-hook 'racer-mode-hook #'eldoc-mode)

 (require 'rust-mode)
 (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common))

(provide 'y-rust)
