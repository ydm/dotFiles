(require 'ido-goto-symbol)

;; Unset system keys
(global-unset-key (kbd "C-x o"))        ; other-frame
(global-unset-key (kbd "C-x C-z"))      ; suspend-frame
(global-unset-key (kbd "C-x z"))        ; repeat

;; Redefine system keys
(global-set-key (kbd "C-o") 'y:open-line)
(global-set-key (kbd "C-x C-b") 'bs-show)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-x") 'smex)

;; Built-in commands
(global-set-key (kbd "<f5>") 'sort-lines)
(global-set-key (kbd "C-M-z") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z")   (lambda () (interactive) (other-window  1)))
(global-set-key (kbd "M-n")   (lambda () (interactive) (next-line     5)))
(global-set-key (kbd "M-p")   (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-.")   #'tabbar-forward-tab)
(global-set-key (kbd "C-,")   #'tabbar-backward-tab)

;; External commands
(global-set-key (kbd "C-c i") #'ido-goto-symbol)
(global-set-key (kbd "C-x f") #'find-file-in-project)
(global-set-key (kbd "C-x j") 'python-django-open-project)
(global-set-key (kbd "s-,") #'mc/mark-previous-like-this)
(global-set-key (kbd "s-.") #'mc/mark-next-like-this)
(global-set-key (kbd "s-<") #'mc/edit-lines)
(global-set-key (kbd "s->") #'mc/mark-all-like-this)
(global-set-key (kbd "s-a") #'ace-jump-mode)
(global-set-key (kbd "s-e") #'er/expand-region)
(global-set-key (kbd "s-z") #'repeat)

;; My external commands
(global-set-key (kbd "C-(") #'y:parentheses-eol)

;; Mode specific commands
(require 'dired)
(define-key dired-mode-map (kbd "/")
  (lambda (regexp)
    (interactive "sFind-grep (grep regexp): ")
    (find-grep-dired default-directory regexp)))

;; Key chords
(defvar y:key-chords
  '(
    ("jj" . (lambda () (interactive) (switch-to-buffer (other-buffer))))
    ))

(add-hook 'after-init-hook
	  (lambda ()
            (mapcar (lambda (e)
                      (key-chord-define-global (kbd (car e)) (cdr e)))
                    y:key-chords)))

(provide 'init-keys)
