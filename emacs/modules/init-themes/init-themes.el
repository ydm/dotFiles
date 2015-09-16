(require 'tomorrow-night-theme)

(cl-loop for theme in custom-enabled-themes do (disable-theme theme))

;; (load-theme 'tomorrow-night t)
(load-theme 'deeper-blue t)

(provide 'init-themes)
