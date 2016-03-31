;; Very mode, such Emacs, Wow!

(add-to-list '*y:packages* '(init-encourage encourage-mode))

(custom-set-variables
 '(encourage-encouragements '("Doge with it"
			      "Many clever"
			      "Many code"
			      "Many creative"
			      "Many smart"
			      "Many thinking"
			      "Much genius"
			      "Much nice"
			      "Much save"
			      "Not bug now, wow"
			      "RMS many happy now, wow"
			      "RMS such proud now, wow"
			      "So Emacs"
			      "So algorithms"
			      "So file"
			      "So work"
			      "Such Emacs"
			      "Such clever"
			      "Such creative"
			      "Such nice"
			      "Such save"
			      "Such smart"
			      "Such work"
			      "Very Emacs"
			      "Very algorithm"
			      "Very code"
			      "Very convention, wow"
			      "Very function"
			      "Very save"
			      "Very work"
			      "Wow")))

(add-hook 'after-init-hook (lambda () (encourage-mode 1)))
(provide 'init-encourage)
