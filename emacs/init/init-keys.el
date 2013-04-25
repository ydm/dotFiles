;; (require 'ido-goto-symbol)

;; Redefine system keys
(global-set-key (kbd "C-x C-b") 'bs-show)
(global-set-key (kbd "C-o") 'y/open-line)
(global-set-key (kbd "M-x") 'smex)

;; Built-in commands
(global-set-key (kbd "<f5>") 'sort-lines)
;; (global-set-key (kbd "C-;") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z") (lambda () (interactive) (other-window  1)))
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line     5)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-unset-key (kbd "C-x o"))

;; External commands
(global-set-key (kbd "C-c i") 'ido-goto-symbol)
(global-set-key (kbd "s-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "s-.") 'mc/mark-next-like-this)
(global-set-key (kbd "s-<") 'mc/edit-lines)
(global-set-key (kbd "s->") 'mc/mark-all-like-this)
(global-set-key (kbd "s-a") 'ace-jump-mode)
(global-set-key (kbd "s-e") 'er/expand-region)

(provide 'init-keys)
