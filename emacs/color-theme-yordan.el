(require 'color-theme)
(defun color-theme-yordan ()
  "My color theme. It rocks, k?
   Created: 2011-August-30
   Last update: 2011-August-30"
  (interactive)
  (color-theme-install
   '(color-theme-yordan
     ()
     (font-lock-comment-face ((t (:foreground "#4261c0" :italic t))))
     (font-lock-variable-name-face ((t (:foreground "#dc143c"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#4261c0" :italic t))))
     (font-lock-string-face ((t (:foreground "#2d04ff"))))
     (show-paren-match-face ((t (:background "green" :bold t)))))))