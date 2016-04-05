;; Very mode, such Emacs, Wow!

(y:install-packages encourage-mode)

(let* ((heads  '("Many"
                 "Much"
                 "So"
                 "Such"
                 "Very"))
       (tails  '("Emacs"
                 "RMS"
                 "algorithm"
		 "bug"
                 "clever"
                 "code"
                 "convention"
                 "creative"
                 "file"
                 "function"
                 "genius"
                 "nice"
                 "save"
                 "smart"
                 "thinking"
                 "work"))
       (unique '("Doge with it"
		 "No bug now, wow"
                 "Wow"))
       (combinations (cl-loop for head in heads append
			      (cl-loop for tail in tails collect
				       (format "%s %s, wow" head tail))))
       (combined (append unique combinations))
       (quoted (list 'quote combined)))
  (custom-set-variables (list 'encourage-encouragements quoted)))

(add-hook 'after-init-hook (lambda () (encourage-mode 1)))
(provide 'init-encourage)
