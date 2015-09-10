(require 'tomorrow-night-theme)

(cl-loop for theme in custom-enabled-themes do (disable-theme theme))
(load-theme 'tomorrow-night t)

(provide 'init-themes)
