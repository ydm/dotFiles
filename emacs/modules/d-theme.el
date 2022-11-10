;; -*- lexical-binding: t; -*-


(d:module
 '((packages doom-themes))

 (when (display-graphic-p)
   (mapcar #'disable-theme custom-enabled-themes)
   (load-theme 'doom-1337 t)))


(provide 'd-theme)
