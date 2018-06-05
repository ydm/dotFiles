(y:module
 '(molokai-theme)

 (mapcar #'disable-theme custom-enabled-themes)
 (load-theme 'molokai t)
 (custom-theme-set-faces
  'molokai
  '(font-lock-comment-face ((t (:foreground "#4CE32D" :slant italic))))
  '(font-lock-comment-delimiter-face ((t (:foreground "#4CE32D" :slant italic))))
  '(markdown-comment-face ((t (:foreground "#4CE32D"))))))

(provide 'y-theme)
