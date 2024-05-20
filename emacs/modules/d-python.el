;; -*- lexical-binding: t -*-

(use-package python
  :init
  (add-hook 'python-mode-hook    #'python-ts-mode)
  (add-hook 'python-ts-mode-hook #'eglot-ensure)
  :ensure t)

(provide 'd-python)
