(add-to-list '*y:packages* '(init-modes haskell-mode))
(add-hook 'haskell-mode-hook (lambda () (subword-mode 1)))
(provide 'init-haskell)
