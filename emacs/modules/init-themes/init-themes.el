;; (require 'tomorrow-night-theme)
(load "monokai-theme.el")

(cl-loop for theme in custom-enabled-themes do (disable-theme theme))

(load-theme 'monokai t)
;; (load-theme 'tomorrow-night t)
;; (load-theme 'deeper-blue t)

(provide 'init-themes)
