(require 'ido-goto-symbol)
(require 'init-interactives)

;; Dependencies:
;;   ido-goto-symbol:
;;     ido-goto-symbol
;;   init-interactives:
;;     y:open-line
;;     y:wrap-in-parentheses

;; Unset system keys
(global-unset-key (kbd "C-x o"))        ; other-frame
(global-unset-key (kbd "C-x C-z"))      ; suspend-frame
(global-unset-key (kbd "C-x z"))        ; repeat
(global-unset-key (kbd "C-x b"))        ; ido-switch-buffer

;; Redefine system keys
(global-set-key (kbd "C-o") #'y:open-line)
(global-set-key (kbd "C-x C-b") #'bs-show)
(global-set-key (kbd "M-x") #'smex)

;; Built-in commands
(global-set-key (kbd "<f5>") #'sort-lines)
(global-set-key (kbd "C-M-z") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z")   (lambda () (interactive) (other-window  1)))

;; External commands
(global-set-key (kbd "C-c i") #'ido-goto-symbol)
(global-set-key (kbd "C-x j") #'python-django-open-project)
(global-set-key (kbd "s-,") #'mc/mark-previous-like-this)
(global-set-key (kbd "s-.") #'mc/mark-next-like-this)
(global-set-key (kbd "s-<") #'mc/edit-lines)
(global-set-key (kbd "s->") #'mc/mark-all-like-this)
(global-set-key (kbd "s-z") #'repeat)
(global-set-key (kbd "s-n") (lambda () (interactive) (next-line     5)))
(global-set-key (kbd "s-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "s-'") #'forward-whitespace)

;; My external commands
(global-set-key (kbd "C-(") #'y:wrap-in-parentheses)

;; Mode specific commands
(define-key dired-mode-map (kbd "/")
  (lambda (regexp)
    (interactive "sFind-grep (grep regexp): ")
    (find-grep-dired default-directory regexp)))

;; Key chords
(defvar y:key-chords
  '(("jj" . (lambda () (interactive) (switch-to-buffer (other-buffer))))
    ("hh" . ace-jump-mode)
    ("bb" . ido-switch-buffer)))

;; If it's a first time Emacs run key-chords is still unpresent, but it will be
;; installed by my package installation mechanism.  That's why I hook to
;; after-init-hook when I know for sure it'll be there up and running
(add-hook 'after-init-hook
	  (lambda ()
            (mapcar (lambda (e)
                      (key-chord-define-global (kbd (car e)) (cdr e)))
                    y:key-chords)))

(provide 'init-keys)
