;; TODO: '(highlight-indent-guides-method 'column)

(use-package nim-mode
  :config
  (add-hook 'nim-mode-hook
            (lambda ()
              (eldoc-mode -1)
              (which-function-mode 1)))
  :ensure t)

(use-package highlight-indent-guides
  :hook nim-mode
  :ensure t)

(provide 'd-nim)
