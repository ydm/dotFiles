(defalias 'yes-or-no-p 'y-or-n-p)	       ; always y/n instead of yes/no
(bar-cursor-mode t)			       ; use bar for point (deb pkg)
(delete-selection-mode t)		       ; delete marked test on insert
(global-linum-mode t)			       ; show line number
(icomplete-mode t)			       ; buffer completion mode
(ido-mode t)				       ; switch fast between buffers
(put 'dired-find-alternate-file 'disabled nil) ; allow nav in dired buffer
(recentf-mode t)			       ; list of recent files
(setq backup-directory-alist '(("." . ".~")))  ; create backups in ./.~ dir
(setq dired-dwim-target t)		       ; 2 panels copy for dired
(setq dired-recursive-copies (quote always))   ; do not ask for rec copies
(setq dired-recursive-deletes (quote top))     ; do ask once for deletions
(setq-default indent-tabs-mode nil)	       ; use spaces instead of tabs
(toggle-word-wrap t)			       ; break long lines on words
(tool-bar-mode -1)			       ; hide tool bar
(which-function-mode t)			       ; show current func in bar
(windmove-default-keybindings)		       ; move trough windows w/ sh/arws
;; (global-hl-line-mode t)		       ; highlight current line
;; (menu-bar-mode -1)			       ; hide menu bar
;; (show-ws-toggle-show-trailing-whitespace)   ; show trailing whitespace
;; (winner-mode t)			       ; track window manipulation

;; auto-complete
;; (add-to-list 'load-path "/home/y/.emacs.d/auto-complete-1.3.1")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories
;;              "/home/y/.emacs.d/auto-complete-1.3.1/ac-dict")
;; (ac-config-default)
;; (define-key ac-completing-map "\M-/" 'ac-stop)

;; bindings
(if (eq window-system 'x)
    (shell-command "xmodmap -e 'clear Lock' -e 'keycode 66 = F13'"))
(global-set-key [f13] 'execute-extended-command) ; CapsLock = M-x

(global-set-key (kbd "C-x C-b")	 'bs-show)	      ; fast buffer switch
(global-set-key (kbd "C-c r")	 'replace-regexp)     ; as advised by emacs wiki

;; colors
(load "/home/y/emacs/color-theme-yordan")
(color-theme-yordan)
(set-face-foreground 'region "white")
(set-face-background 'region "light green")

;; dbg
(setq gdb-many-windows t)

;; etags
;; Browse through multiple matching tags.
;; http://www.emacswiki.org/emacs/EtagsSelect
(load "/home/y/emacs/etags-select")
(require 'etags-select)
(global-set-key "\M-." 'etags-select-find-tag-at-point)

;; flymake minor mode
;; (load "/home/y/emacs/my-flymake-minor-mode")
(load "/home/y/emacs/flymake-errnav-mode")

;; javascript: jslint and node.js
(add-to-list 'load-path "/home/y/emacs/plugins/lintnode")
(require 'flymake-jslint)
(add-hook 'js-mode-hook
	  (lambda ()
	    (subword-mode 1)
	    (flymake-mode 1)
	    (flymake-errnav-mode)))

;; tabbar-mode
(tabbar-mode 1)
(global-set-key (kbd "C-<next>") 'tabbar-forward)
(global-set-key (kbd "C-<prior>") 'tabbar-backward)

;; window auto size
;; (load "/home/y/emacs/emacs-window-auto-size")

;; yasnippet
(add-to-list 'load-path "/home/y/emacs/plugins/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

;; emacs generated
(custom-set-variables
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(use-dialog-box nil)
 '(x-select-enable-clipboard t))

(custom-set-faces)

;; todo
;; dired tips --> http://xahlee.org/emacs/emacs_dired_tips.html

;; etags
;; Jump to standard library definitions.
;; http://www.emacswiki.org/emacs/EtagsTable
;; (load "/home/y/emacs/etags-table")
;; (require 'etags-table)
;; (setq etags-table-search-up-depth 16)
;; (setq etags-table-alist
;;	 (list
;;	  ;; '(".*\\.\\([ch]\\|hpp\\|cpp\\)" "/usr/include/TAGS")
;;	  '(".*\\.\\([ch]\\)" "/usr/include/TAGS")))
