(y:module
 ;; '(molokai-theme)
 '(atom-dark-theme)

 (mapcar #'disable-theme custom-enabled-themes)
 (load-theme 'atom-dark t)
 
 ;; (mapcar #'disable-theme custom-enabled-themes)
 ;; (load-theme 'molokai t)
 ;; (custom-theme-set-faces
 ;;  'molokai
 ;;  '(diff-refine-added ((t :underline t)))
 ;;  '(diff-refine-removed ((t :strike-through t)))
 ;;  '(font-lock-comment-delimiter-face ((t :foreground "#4CE32D" :slant italic)))
 ;;  '(font-lock-comment-face ((t :foreground "#4CE32D" :slant italic)))
 ;;  '(markdown-comment-face ((t (:foreground "#4CE32D"))))
 ;;  '(smerge-refined-added ((t :underline t)))
 ;;  '(smerge-refined-removed ((t :strike-through t)))
 ;;  '(smerge-lower ((t nil)))
 ;;  ;; '(ansi-color-face ((t (:foreground "#..."))))
 ;;  )
 )

(provide 'y-theme)
