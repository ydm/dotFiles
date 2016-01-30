;; Very mode, such fun, wow

(add-to-list '*y:packages* '(init-encourage encourage-mode))

(custom-set-variables
 '(encourage-encouragements '("Doge with it"
			      "Many code"
			      "Many creative"
			      "Much genius"
			      "Much nice"
			      "Much save"
			      "Not bug now. Wow"
			      "So Emacs"
			      "So algorithms"
			      "So file"
			      "So work"
			      "Such clever. Wow"
			      "Such creative"
			      "Such save"
			      "Very Emacs"
			      "Very code"
			      "Very convention. Wow"
			      "Very function"
			      "Wow")))

(add-hook 'after-init-hook (lambda () (encourage-mode 1)))
(provide 'init-encourage)
