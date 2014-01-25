(require 'dired)
(require 'python)
(require 'thingatpt)

(require 'ido-goto-symbol)
(require 'init-interactives)

;; Dependencies:
;;   dired:
;;     'dired-mode-map
;;   python:
;;     'python-mode-map
;;   thingatpt
;;     (forward-whitespace)
;;   ido-goto-symbol:
;;     (ido-goto-symbol)
;;   init-interactives:
;;     (y:open-line)
;;     (y:python-run)
;;     (y:python-run-main)
;;     (y:python-rerun)
;;     (y:wrap-in-parentheses)

;; Unset system keys
(global-unset-key (kbd "C-o"))          ; (open-line)
(global-unset-key (kbd "C-x C-b"))      ; (list-buffers)
(global-unset-key (kbd "C-x C-z"))      ; (suspend-frame)
(global-unset-key (kbd "C-x b"))        ; (ido-switch-buffer)
(global-unset-key (kbd "C-x o"))        ; (other-frame)
(global-unset-key (kbd "C-x z"))        ; (repeat)
(global-unset-key (kbd "M-,"))          ; (tags-loop-continue)
(global-unset-key (kbd "M-."))          ; (find-tag)
(global-unset-key (kbd "M-x"))          ; (execute-extend-command)

;; Redefine system keys
(global-set-key (kbd "C-o") #'y:open-line)
(global-set-key (kbd "C-x C-b") #'bs-show)
(global-set-key (kbd "M-.") #'etags-select-find-tag)
(global-set-key (kbd "M-x") #'smex)

;; Built-in commands
(global-set-key (kbd "<f5>") #'sort-lines)
(global-set-key (kbd "C-M-z") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-z")   (lambda () (interactive) (other-window  1)))

;; External commands
(global-set-key (kbd "C-x j") #'python-django-open-project)
(global-set-key (kbd "s-,") #'mc/mark-previous-like-this)
(global-set-key (kbd "s-.") #'mc/mark-next-like-this)
(global-set-key (kbd "s-<") #'mc/edit-lines)
(global-set-key (kbd "s->") #'mc/mark-all-like-this)
(global-set-key (kbd "s-z") #'repeat)

;; My external commands
(global-set-key (kbd "C-(") #'y:wrap-in-parentheses)
(global-set-key (kbd "C-c i") #'ido-goto-symbol)
(global-set-key (kbd "s-n") (lambda () (interactive) (next-line     5)))
(global-set-key (kbd "s-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "s-o") #'forward-whitespace)

;; Mode specific commands
(define-key dired-mode-map (kbd "/")
  (lambda (regexp)
    (interactive "sFind-grep (grep regexp): ")
    (find-grep-dired default-directory regexp)))

(define-key python-mode-map (kbd "<f9>") #'y:python-run)
(define-key python-mode-map (kbd "C-<f9>")
  (lambda () (interactive) (y:python-run t)))

(define-key python-mode-map (kbd "<f10>") #'y:python-run-main)
(define-key python-mode-map (kbd "C-<f10>")
  (lambda () (interactive) (y:python-run-main t)))

(define-key python-mode-map (kbd "<f11>") #'y:python-rerun)
(define-key python-mode-map (kbd "C-<f11>")
  (lambda () (interactive) (y:python-rerun t)))

;; Key chords
(defvar y:key-chords
  '(("jj" . (lambda () (interactive) (switch-to-buffer (other-buffer))))
    ("hh" . ace-jump-mode)
    ("vv" . ido-switch-buffer)))

;; If that's the first time Emacs is run, key-chords is still not
;; installed.  That's why we hook to 'after-init-hook, when we know for
;; sure it will be installed and present
(add-hook 'after-init-hook
	  (lambda ()
            (mapcar (lambda (e)
                      (key-chord-define-global (kbd (car e)) (cdr e)))
                    y:key-chords)))

(provide 'init-keys)
