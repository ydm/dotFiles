(y:module
 '((packages challenger-deep-theme)
   (hookvar . y-theme-hook))

 (defun fixes ()
   ;; TT, it doesn't work (anymore)...
   ;; (add-hook 'y-theme-hook
   ;;           (lambda ()
   ;;             ;; Once my theme is loaded, this hook gets fired (see
   ;;             ;; y:module).  It invokes (custom-theme-set-faces) for
   ;;             ;; the currently enabled theme and modifies the
   ;;             ;; `which-func' face by making it inherit the
   ;;             ;; `font-lock-function-name-face' property of the
   ;;             ;; current theme.  This way (which-function-mode)
   ;;             ;; doesn't try to guess (it does that BAD) what color
   ;;             ;; the face should be.
   ;;             (message "UPDATING %s" (car custom-enabled-themes))
   ;;             (custom-theme-set-faces
   ;;              (car custom-enabled-themes)
   ;;              '(which-func ((t :inherit font-lock-function-name-face
   ;;                               :slant normal))))))
   )

 (when (display-graphic-p)
   (mapcar #'disable-theme custom-enabled-themes)
   (fixes)
   (load-theme 'challenger-deep t))
 )

(provide 'y-theme)
