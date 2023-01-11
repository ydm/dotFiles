;; -*- lexical-binding: t; -*-

(d:module
 '((package autothemer
            catppuccin-theme
            ;; doom-themes
            ))

 (when (display-graphic-p)
   (mapcar #'disable-theme custom-enabled-themes)
   (load-theme 'catppuccin-mocha t)
   ;; (load-theme 'doom-1337 t)
   ))

(provide 'd-theme)
