(require 'rcirc)

;; # pacman -S beep
;; # chmod 4755 /usr/bin/beep

(add-hook 'rcirc-print-hooks 'my-rcirc-print-hook)
(defun my-rcirc-print-hook (process sender response target text)
  (when (and (string-match (regexp-quote (rcirc-nick process)) text)
             (not (string-match "@irc\." (format "%s" (selected-frame))))
	     (not (string= (rcirc-nick process) sender))
	     (not (string= (rcirc-server-name process) sender)))
    (start-process "emacs-rcirc-beep" nil "beep" "-f2000" "-l100" "-r2")))

(provide 'init-rcirc)
