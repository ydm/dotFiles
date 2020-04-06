(y:module
 '((packages atom-one-dark-theme)
   (hookvar . y-theme-hook))

 (mapcar #'disable-theme custom-enabled-themes)
 (load-theme 'atom-one-dark t))

;; Once my theme is loaded, this hook gets fired (see y:module).  It
;; invokes (custom-theme-set-faces) for the currently enabled theme
;; and modifies the `which-func' face by making it inherit the
;; `font-lock-function-name-face' property of the current theme.  This
;; way (which-function-mode) doesn't try to guess (for good) what
;; color the face should be.
(add-hook 'y-theme-hook
          (lambda ()
            (custom-theme-set-faces
             (car custom-enabled-themes)
             '(which-func ((t :inherit font-lock-function-name-face
                              :slant normal))))))

(provide 'y-theme)
