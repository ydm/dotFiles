(defalias 'yes-or-no-p 'y-or-n-p)	       ; always y/n instead of yes/no
(delete-selection-mode t)		       ; delete marked text on insert
(flymake-mode -1)			       ; let it be off by default
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
(windmove-default-keybindings)		       ; move trough windows w. sh/arws
;; (desktop-load-default)
;; (desktop-save-mode 1)                       ; restore last emacs session
;; (global-ede-mode t)			       ; + ide features
;; (global-linum-mode t)		       ; show line number
;; (menu-bar-mode 0)			       ; hide menu bar
;; (show-ws-toggle-show-trailing-whitespace)   ; show trailing whitespace
;; (winner-mode t)			       ; track window manipulation

;; config

;; vars
(defvar my-emacs-directory "~/emacs/")

;; bindings
(global-set-key (kbd "C-c e")	'eshell)	 ; emacs shell
(global-set-key (kbd "C-c r")	'replace-regexp) ; as advised by emacs wiki
(global-set-key (kbd "C-x C-b") 'bs-show)	 ; fast buffer switch

;; subword mode for some languages
(add-hook 'java-mode-hook   (lambda () (subword-mode 1))) ; java
(add-hook 'js-mode-hook	    (lambda () (subword-mode 1))) ; js
(add-hook 'python-mode-hook (lambda () (subword-mode 1))) ; python

;; auto-comlpete
(add-to-list 'load-path (concat my-emacs-directory "popup-el"))
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(ac-config-default)

;; bar cursor mode
(load (concat my-emacs-directory "bar-cursor"))
(bar-cursor-mode t)

;; etags-select http://www.emacswiki.org/emacs/EtagsSelect
(load (concat my-emacs-directory "etags-select"))
(require 'etags-select)
(global-set-key (kbd "C-M-.") 'etags-select-find-tag)
(global-set-key (kbd "M-.")   'etags-select-find-tag-at-point)

;; flymake-errnav minor mode: C-<end> and C-<home> to navigate between errors
(load (concat my-emacs-directory "flymake-errnav-mode"))
(add-hook 'flymake-mode (lambda () (flymake-errnav-mode)))

;; flymake for elisp
;; (defun flymake-elisp-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "elisplint" (list local-file))))
;; (push '("\\.el$" flymake-elisp-init) flymake-allowed-file-name-masks)
;; (add-hook 'emacs-lisp-mode-hook
;;           ;; workaround for (eq buffer-file-name nil)
;;           (function (lambda () (if buffer-file-name (flymake-mode)))))

;; flymake for js using jslint
(load (concat my-emacs-directory "flymake-jslint"))

;; folding-mode
(load (concat my-emacs-directory "folding"))
;; (add-hook 'html-mode (lambda () (folding-mode)))

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

;; yaml
;; (add-to-list 'load-path (concat my-emacs-directory "plugins/yaml-mode"))
;; (require 'yaml-mode)
(load (concat my-emacs-directory "plugins/yaml-mode/yaml-mode"))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; yasnippet
(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/yasnippet/snippets"
        "~/.emacs.d/snippets"))
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
 '(inhibit-default-init nil)
 '(inhibit-startup-screen t)
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
