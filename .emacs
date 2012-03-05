(defalias 'yes-or-no-p 'y-or-n-p)	       ; always y/n instead of yes/no
(delete-selection-mode t)		       ; delete marked text on insert
(global-hl-line-mode t)			       ; highlight current line
(global-linum-mode t)			       ; show line number
(icomplete-mode t)			       ; buffer completion mode
(ido-mode t)				       ; switch fast between buffers
(put 'dired-find-alternate-file 'disabled nil) ; allow nav in dired buffer
(recentf-mode t)			       ; list of recent files
(setq backup-directory-alist '(("." . ".~")))  ; create backups in ./.~ dir
(setq dired-dwim-target t)		       ; 2 panels copy for dired
(setq dired-recursive-copies (quote always))   ; do not ask for rec copies
(setq dired-recursive-deletes (quote top))     ; ask only once for rec del
(setq-default indent-tabs-mode nil)	       ; use spaces instead of tabs
(toggle-word-wrap t)			       ; break long lines on words
(tool-bar-mode -1)			       ; hide tool bar
(which-function-mode t)			       ; show current func in bar
(windmove-default-keybindings)		       ; move trough windows w. sh/arws
;; (global-ede-mode t)			       ; + ide features
;; (menu-bar-mode -1)			       ; hide menu bar
;; (show-ws-toggle-show-trailing-whitespace)   ; show trailing whitespace
;; (winner-mode t)			       ; track window manipulation

;; bindings
(if (eq window-system 'x)
    (shell-command "xmodmap -e 'clear Lock' -e 'keycode 66 = F13'"))
(global-set-key [f13] 'execute-extended-command) ; CapsLock = M-x

(global-set-key (kbd "C-x C-b") 'bs-show)	 ; fast buffer switch
(global-set-key (kbd "C-c r")	'replace-regexp) ; as advised by emacs wiki
(global-set-key (kbd "C-c e")   'eshell)         ; emacs shell

;; bar cursor mode
(load "~/emacs/bar-cursor")
(bar-cursor-mode t)

;; colors
;; TODO: unresolved dependencies
;; (load "~/emacs/color-theme-yordan")
;; (color-theme-yordan)
;; (set-face-foreground 'region "white")
;; (set-face-background 'region "light green")

;; dbg
(setq gdb-many-windows t)

;; etags-select
;; Browse through multiple matching tags.
;; http://www.emacswiki.org/emacs/EtagsSelect
(load "~/emacs/etags-select")
(require 'etags-select)
(global-set-key "\M-." 'etags-select-find-tag-at-point)

;; flymake errnav minor mode
;; C-<end> and C-<home> to navigate between errors
(load "~/emacs/flymake-errnav-mode")
;; enable it along with flymake-mode
(add-hook 'flymake-mode
	  (lambda ()
	    (flymake-errnav-mode)))

;; javascript: jslint and node.js
;; (add-to-list 'load-path "~/emacs/plugins/lintnode")
;; (require 'flymake-jslint)
(add-hook 'js-mode-hook
	  (lambda ()
	    (subword-mode 1)))

;; org
(setq load-path (cons "~/emacs/plugins/org/lisp" load-path))
;; contrib?
(setq load-path (cons "~/emacs/plugins/org/contrib/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; file association
(global-set-key "\C-c1" 'org-store-link)		 ;keys
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; python
(add-hook 'python-mode-hook
          (lambda ()
            (subword-mode 1)))

;; yasnippet
(add-to-list 'load-path "~/emacs/plugins/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

;; generated by emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(use-dialog-box nil)
 '(x-select-enable-clipboard t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; TODO
;; dired tips --> http://xahlee.org/emacs/emacs_dired_tips.html
