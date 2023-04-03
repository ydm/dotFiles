;; -*- lexical-binding: t -*-

;; Usage: add
;; 
;; (use-package d-init :ensure nil :load-path "~/dotFiles/emacs")
;; 
;; at the beginning of your .emacs config.

(custom-set-variables
 ;; Pacakges
 '(package-archives
   '(("melpa" . "http://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))

 ;; Misc
 '(backup-directory-alist '(("." . "~/.emacs.d/backup")))
 '(compilation-always-kill t)
 '(compilation-scroll-output 'first-error)
 '(default-input-method "bulgarian-alt-phonetic")
 '(delete-selection-mode t)
 '(gc-cons-threshold 33554432)
 '(gdb-many-windows t)
 '(inhibit-startup-screen t)
 '(mouse-yank-at-point t)
 '(safe-local-variable-values '((git-commit-major-mode . git-commit-elisp-text-mode)))
 '(scroll-error-top-bottom t)
 '(scroll-preserve-screen-position t)
 '(truncate-lines t)

 ;; Global minor modes.
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(line-number-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)

 ;; Mode tweaks.
 '(calendar-week-start-day 1)
 '(eldoc-minor-mode-string " ed")
 '(hs-hide-comments-when-hiding-all nil)
 '(image-dired-thumb-size 192)
 '(indent-tabs-mode nil)
 '(show-paren-mode t)

 ;; Ido
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido)))

(custom-set-faces
 '(default ((t (:family "Cascadia Mono" :foundry "SAJA" :slant normal :weight regular :height 158 :width normal)))))

(defalias 'yes-or-no-p #'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Hook to the after-init-hook before bootstrapping.  Adding this
;; function first ensures that it is invoked *before* any other added
;; eventually to the same hook.
(add-hook 'after-init-hook (lambda () (run-hooks 'd:last)))

;; Dynamically load modules.
;;
;; `use-package` cannot work (maybe because it's a macro) with
;; variables for the :load-path option, among others. So, in order to
;; load modules from files, I define another higher-level macro that
;; constructs a list of dynamically built `use-package` applications.
;;
;; Here's what a typical expansion looks like:
;;
;; (progn
;;   (use-package d-company :ensure nil :load-path "~/dotFiles/emacs/modules")
;;   (use-package d-theme :ensure nil :load-path "~/dotFiles/emacs/modules"))
(defmacro d:bootstrap ()
  (let* ((root "~/dotFiles/emacs/modules")
         (mods (directory-files root t "^d-.*\\.el$")))
    `(progn
       ,@(mapcar (lambda (path)
                   (let* ((base (file-name-base path))
                          (symbol (intern base)))
                     (message "[Y] d:bootstrap: symbol=%20s path=%s" symbol root)
                     `(use-package ,symbol :ensure nil :load-path ,root)))
                 mods))))
(d:bootstrap)

(provide 'd-init)
