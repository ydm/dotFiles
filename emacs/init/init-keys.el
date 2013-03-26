(require 'ido-goto-symbol)

;; Redefine system keys
(global-set-key (kbd "C-x C-b") 'bs-show)
(global-set-key (kbd "M-x") 'smex)

;; My keys
(global-set-key (kbd "<f5>") 'sort-lines)
(global-set-key (kbd "C-c C-a") 'ace-jump-mode)
(global-set-key (kbd "C-c a") 'ace-jump-mode)
(global-set-key (kbd "C-c C-e") 'er/expand-region)
(global-set-key (kbd "C-c e") 'er/expand-region)
(global-set-key (kbd "C-c i") 'ido-goto-symbol)
(global-set-key (kbd "C-c m ,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m .") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c m >") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m m") 'mc/edit-lines)

;; (global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))
;; (global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))

(global-set-key (kbd "M-n") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (other-window -1)))
(global-unset-key (kbd "C-x o"))

(provide 'init-keys)
