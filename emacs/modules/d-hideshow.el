;; -*- lexical-binding: t; -*-


(d:module
 '()

 (require 'hideshow)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-a") #'hs-show-all)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-c") #'hs-toggle-hiding)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-d") #'hs-hide-block)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-e") #'hs-toggle-hiding)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-h") #'hs-hide-block)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-l") #'hs-hide-level)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-s") #'hs-show-block)
 (define-key hs-minor-mode-map (kbd "C-c C-2 C-t") #'hs-hide-all)

 (add-hook 'prog-mode-hook #'hs-minor-mode))


(provide 'd-hideshow)
