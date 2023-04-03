;; -*- lexical-binding: t -*-

(use-package use-package-chords
  :config (key-chord-mode 1)
  :ensure t)

(use-package ido :chords ("vv" . ido-switch-buffer))

(use-package ace-jump-mode
  :ensure t
  :chords ("hh" . ace-jump-mode))

(use-package ace-window
  :ensure t
  :chords ("ww" . ace-window))

(use-package d-interactives
  :load-path "~/dotFiles/emacs/library"
  :chords ("jj" . d:keychords/switch-to-last-buffer))

(provide 'd-keychords)
