(defalias 'yes-or-no-p 'y-or-n-p)	       ; always y/n instead of yes/no
(delete-selection-mode t)		       ; delete marked text on insert
(global-hl-line-mode t)			       ; highlight current line
(icomplete-mode t)			       ; buffer completion mode
(ido-mode t)				       ; switch fast between buffers
(put 'dired-find-alternate-file 'disabled nil) ; allow nav in dired buffer
(recentf-mode t)			       ; list of recent files
(setq backup-directory-alist '(("." . ".~")))  ; create backups in ./.~ dir
(setq dired-dwim-target t)		       ; 2 panels copy for dired
(setq dired-recursive-copies (quote always))   ; do not ask for rec copies
(setq dired-recursive-deletes (quote top))     ; ask only once for rec del
(setq visible-bell t)                          ; make my emacs blink on err
(setq-default indent-tabs-mode nil)	       ; use spaces instead of tabs
(toggle-word-wrap t)			       ; break long lines on words
(which-function-mode t)			       ; show current func in bar
;; (desktop-load-default)
;; (desktop-save-mode 1)                       ; restore last emacs session
;; (flymake-mode -1)			       ; let it be off by default
;; (global-ede-mode t)			       ; + ide features
;; (global-linum-mode t)		       ; show line number
;; (menu-bar-mode 0)			       ; hide menu bar
;; (show-ws-toggle-show-trailing-whitespace)   ; show trailing whitespace
;; (windmove-default-keybindings)	       ; move trough windows w. sh/arws
;; (winner-mode t)			       ; track window manipulation

;; testing
(setq redisplay-dont-pause t)

;; config

;; vars
(defvar my-emacs-directory "~/emacs/")

;; bindings
(global-set-key (kbd "C-c e")	'shell)          ; shell
(global-set-key (kbd "C-c r")	'replace-regexp) ; as advised by emacs wiki
(global-set-key (kbd "C-x C-b") 'bs-show)	 ; fast buffer switch
(global-set-key (kbd "C-M-p")                    ; jump 5 lines up
                (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-M-n")                    ; jump 5 lines down
                (lambda () (interactive) (next-line 5)))

;; subword mode for some languages
(add-hook 'java-mode-hook   (lambda () (subword-mode 1))) ; java
(add-hook 'js2-mode-hook	    (lambda () (subword-mode 1))) ; js
(add-hook 'python-mode-hook (lambda () (subword-mode 1))) ; python

;; auto-comlpete
(add-to-list 'load-path (concat my-emacs-directory "popup-el"))
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(ac-config-default)

;; bar cursor mode
(load (concat my-emacs-directory "bar-cursor"))
(bar-cursor-mode t)

;; TODO: remove this...
;; (load (concat my-emacs-directory "plugins/django-mode/django-html-mode"))
;; (load (concat my-emacs-directory "plugins/django-mode/django-mode"))

;; etags-select http://www.emacswiki.org/emacs/EtagsSelect
(load (concat my-emacs-directory "etags-select"))
(require 'etags-select)
(global-set-key (kbd "C-M-.") 'etags-select-find-tag)
(global-set-key (kbd "M-.")   'etags-select-find-tag-at-point)

;; flymake-errnav minor mode: C-<end> and C-<home> to navigate between errors
(load (concat my-emacs-directory "flymake-errnav-mode"))
(add-hook 'flymake-mode (lambda () (flymake-errnav-mode)))

;; flymake for js using jslint
(load (concat my-emacs-directory "flymake-jslint"))
(add-hook 'js2-mode-hook (lambda () (flymake-mode 1)))

;; hide/show minor mode for various languages
(add-hook 'python-mode (lambda () (hs-minor-mode)))

;; less-css
(load (concat my-emacs-directory "less-css-mode"))

;; php-mode
(load (concat my-emacs-directory "plugins/php-mode/php-mode"))
(setq auto-mode-alist
      (cons '("\\.php" . php-mode) auto-mode-alist))

;; po-mode for gettext
(load (concat my-emacs-directory "plugins/po-mode/po-mode"))
(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
                            'po-find-file-coding-system)
(autoload 'po-find-file-coding-system "po-mode")

;; pony-mode for django (it's shit...)
;; (load (concat my-emacs-directory "plugins/pony-mode/src/pony-mode"))

;; yaml
(load (concat my-emacs-directory "plugins/yaml-mode/yaml-mode"))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; yasnippet
(setq yas-snippet-dirs
      `("~/.emacs.d/plugins/yasnippet/snippets"
        "~/.emacs.d/snippets"
        ,(concat my-emacs-directory "plugins/pony-mode/src/snippets")))
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; TAGS
;; If there is a file /usr/include/TAGS, load it with C
(defvar c-tags-file "/usr/include")
(defadvice c-mode (before load-tags-for-c-mode ())
  (if (file-exists-p c-tags-file)
      (visit-tags-table c-tags-file)))

;; Tramp settings
(require 'tramp)
(add-to-list 'tramp-default-proxies-alist
             '("4w\\'" "\\`root\\'" "/ssh:%h:"))

;; TODO:
;; dbg TODO: http://www.emacswiki.org/emacs/DebuggingWithEmacs (setq gdb-many-windows t)
;; dired tips --> http://xahlee.org/emacs/emacs_dired_tips.html

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (dichromacy)))
 '(default-input-method "bulgarian-alt-phonetic")
 '(ido-enable-flex-matching t)
 '(inhibit-default-init nil)
 '(inhibit-startup-screen t)
 '(less-css-compile-at-save t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-position (quote right))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(use-dialog-box nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 128 :width normal)))))

;; TODO
;; Helper for compilation. Close the compilation window if
;; there was no error at all. (emacs wiki)
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete the *compilation* window
    (set-window-buffer (get-buffer-window (get-buffer "*compilation*")) (other-buffer)))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;; Specify my function (maybe I should have done a lambda function)
(setq compilation-exit-message-function 'compilation-exit-autoclose)
