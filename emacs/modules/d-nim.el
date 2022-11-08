;; -*- lexical-binding: t; -*-

(d:module
 '((packages highlight-indent-guides nim-mode))
 (add-hook 'nim-mode-hook
           (lambda ()
             (eldoc-mode -1)
             (highlight-indent-guides-mode 1)
             (which-function-mode 1))))

(provide 'd-nim)
