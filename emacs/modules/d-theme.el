;; -*- lexical-binding: t -*-

(use-package catppuccin-theme
  :init
  (when (display-graphic-p)
    (mapcar #'disable-theme custom-enabled-themes)
    (load-theme 'catppuccin t))
  :ensure t)

(provide 'd-theme)
