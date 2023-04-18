;; -*- lexical-binding: t -*-

(use-package catppuccin-theme
  :init
  (when (display-graphic-p)
    (mapcar #'disable-theme custom-enabled-themes)
    (load-theme 'catppuccin t))
  :custom-face
  (shadow ((t (:foreground "#8a8fb0")))) ; Brighter comments.
  :ensure t)

(provide 'd-theme)
