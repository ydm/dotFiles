;; -*- lexical-binding: t -*-

(use-package use-package-chords
  :config (key-chord-mode 1)
  :ensure t)

(use-package ido
  :after use-package-chords
  :chords ("vv" . ido-switch-buffer))

(use-package ace-jump-mode
  :demand
  :after use-package-chords
  :ensure t
  :chords ("hh" . ace-jump-mode))

(use-package ace-window
  :demand
  :after use-package-chords
  :ensure t
  :chords ("ww" . ace-window))

(use-package d-interactives
  :demand
  :after use-package-chords
  :load-path "~/dotFiles/emacs/libraries"
  :chords ("jj" . d:keychords/switch-to-last-buffer))

(provide 'd-keychords)
