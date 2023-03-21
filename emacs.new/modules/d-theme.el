;; -*- lexical-binding: t; -*-

(use-package catppuccin-theme
  :ensure t
  :config
  (when (display-graphic-p)
    (mapcar #'disable-theme custom-enabled-themes)
    (load-theme 'catppuccin t)
    ;; (custom-set-variables
    ;;  '(catppuccin-flavor 'mocha))
    (custom-set-faces
     '(eglot-highlight-symbol-face ((t (:background "gray23")))))))

(when (and (display-graphic-p)
           (find-font (font-spec :name "Cascadia Code")))
  (custom-set-faces
   '(default ((t (:family "Cascadia Mono" :foundry "SAJA" :slant normal :weight regular :height 158 :width normal))))))

(provide 'd-theme)
