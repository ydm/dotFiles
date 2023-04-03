;; -*- lexical-binding: t -*-

;; This file concentrates *all* of my custom keybindings.
;;
;; Use M-x describe-personal-keybindings for a full list.

(require 'dired)                        ; dired-mode-map
(require 'prog-mode)                    ; prog-mode-map

;; Unbind system keys which I don't use or will remap later.
(unbind-key "C-<delete>")               ; kill-word
(unbind-key "C-<insert>")               ; kill-ring-save
(unbind-key "C-<next>")                 ; scroll-left
(unbind-key "C-<prior>")                ; scroll-right
(unbind-key "C-o")                      ; open-line
(unbind-key "C-x o")                    ; other-window
;; Using [remap] on `find-file-read-only' doesn't work because of ido,
;; we I have to use unbind && bind.
(unbind-key "C-x C-r")                  ; find-file-read-only

;; Remap system commands.
(bind-key [remap list-buffers] #'bs-show)
(bind-key [remap zap-to-char]  #'zap-up-to-char)
(use-package smex
  :bind ([remap execute-extended-command] . smex)
  :ensure t)

;; Bind new key sequences.  I also reuse some system keys without
;; [remap] as their original commands are bound to multiple keys, thus
;; [remap] would cause the implicit effect to bind on other keys as
;; well.
(bind-key "C-<delete>" #'window-swap-states) ; kill-word

;; TODO
;; (use-package eglot
;;   :bind (("s-i"        . eglot-format)       ; new
;;          ([M-f1]       . eglot-code-actions) ; new
;;          ([M-f2]       . eglot-rename)))     ; new

(use-package flymake
  :bind (("C-<next>"   . flymake-goto-next-error)   ; scroll-left
         ("C-<prior>"  . flymake-goto-prev-error))) ; scroll-right

(use-package vterm
  :custom (vterm-max-scrollback 16384)
  :ensure t)
(use-package vterm-toggle
  :bind ("C-`"        . vterm-toggle)   ; new
  :demand
  :ensure t)

(use-package d-interactives
  :bind (("C-o"        . d:open-line)             ; open-line
         ("C-x C-r"    . d:revisit-with-sudo)     ; find-file-read-only [!]
         ("M-n"        . d:5-next)                ; new
         ("M-p"        . d:5-prev)                ; new
         ("s-o"        . forward-whitespace)      ; new
         :map prog-mode-map                       ;
         ("C-'"        . d:wrap-in-single-quotes) ; new
         ("C-("        . d:wrap-in-parenthesis)   ; new
         ("C-<"        . d:wrap-in-angle-braces)  ; new
         
         ("C-\""       . d:wrap-in-double-quotes) ; new
         ("C-c i"      . d:ido-imenu)             ; new
         ("C-{"        . d:wrap-in-curly-braces)  ; new
         :map dired-mode-map
         ("/"          . d:ripgrep))
  :load-path "~/dotFiles/emacs/library")

(use-package d-windows
  :bind ("C-<insert>" . d:windows/restore) ; kill-ring-save
  :load-path "~/dotFiles/emacs/library")

(provide 'd-globals)
