(y:install-packages haskell-mode)
(add-hook 'haskell-mode-hook (lambda () (subword-mode 1)))
(provide 'init-haskell)
