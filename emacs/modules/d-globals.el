;; -*- lexical-binding: t -*-

(use-package smex
  :bind ([remap execute-extended-command] . #'smex)
  :ensure t)

;; Unbind system keys which I don't use.
(unbind-key "C-x o")                    ; other-window

;; I also unbind find-file-read-only.  It's actually getting remapped
;; later manually as [remap] doesn't work because of ido.
(unbind-key "C-x C-r")                  ; find-file-read-only

;; Remap system keys using [remap].
(bind-key [remap list-buffers]          #'bs-show)
(bind-key [remap zap-to-char]           #'zap-up-to-char)

;; Bind new key sequences.  I also remap some system keys without
;; using [remap] as their original commands are bound to multiple
;; keys, thus [remap] would have an implicit effect on other keys as
;; well.
(bind-key "C-<delete>" #'window-swap-states) ; kill-word

(use-package d-interactives
  :bind (("C-o"        . d:open-line)             ; open-line
         ("C-x C-r"    . d:revisit-with-sudo)     ; find-file-read-only [!]
         ("C-`"        . vterm-toggle)            ; new, autoloaded in d-packages
         ("M-n"        . d:5-next)                ; new
         ("M-p"        . d:5-prev)                ; new
         ("s-o"        . forward-whitespace)      ; new
         :map prog-mode-map                       ;
         ("C-c i"      . d:ido-imenu)             ; new
         ("C-'"        . d:wrap-in-single-quotes) ; new
         ("C-("        . d:wrap-in-parenthesis)   ; new
         ("C-<"        . d:wrap-in-angle-braces)  ; new
         ("C-\""       . d:wrap-in-double-quotes) ; new
         ("C-{"        . d:wrap-in-curly-braces)) ; new
  :load-path "~/dotFiles/emacs/library")

(use-package d-windows
  :bind ("C-<insert>" . d:windows/restore) ; kill-ring-save
  :load-path "~/dotFiles/emacs/library")

(provide 'd-globals)
