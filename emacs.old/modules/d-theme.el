;; -*- lexical-binding: t; -*-

(d:module
 '((packages catppuccin-theme))

 (when (display-graphic-p)
   (mapcar #'disable-theme custom-enabled-themes)
   (load-theme 'catppuccin t)))

(provide 'd-theme)
