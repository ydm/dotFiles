;; -*- lexical-binding: t -*-

;; Turn off the electric-indent-mode for the rare cases I have to
;; suffer with HTML.
(add-hook 'html-mode (lambda () (electric-indent-mode -1)))

(use-package mmm-mode
  :config
  (mmm-add-group
   'html-css
   '((css-style-cdata
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style[^>]*>[ \t\n]*\\(//\\)?<!\\[CDATA\\[[ \t]*\n?"
      :back "[ \t]*\\(//\\)?]]>[ \t\n]*</style>"
      :insert ((?c css-tag nil @ "<style type=\"text/css\">"
                   @ "\n" _ "\n" @ "</style>" @)))

     (css-style
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style[^>]*?>"
      :back "</style>"
      :insert ((?c css-tag nil @ "<style type=\"text/css\">"
                   @ "\n" _ "\n" @ "</style>" @)))

     ;; (css-inline
     ;;  :submode css-mode
     ;;  :face mmm-code-submode-face
     ;;  :front "style=\""
     ;;  :back "\"")
     ))
  :ensure t)

;; TODO: skewer-mode

(provide 'd-html)
