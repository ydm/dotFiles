;; usage: add (use-package d-init :load-path "~/dotFiles/emacs") as
;; the first line in your .emacs config

;; +---------+
;; | General |
;; +---------+

(custom-set-variables
 ;; Pacakges
 '(package-archives
   '(("melpa" . "http://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))

 ;; Misc
 '(backup-directory-alist '(("." . "~/.emacs.d/backup")))
 '(calendar-week-start-day 1)
 '(compilation-always-kill t)
 '(compilation-scroll-output 'first-error)
 '(default-input-method "bulgarian-alt-phonetic")
 '(delete-selection-mode t)
 '(gc-cons-threshold 33554432)
 '(gdb-many-windows t)
 '(highlight-indent-guides-method 'column)
 '(hs-hide-comments-when-hiding-all nil)
 '(image-dired-thumb-size 150)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mouse-yank-at-point t)
 '(safe-local-variable-values '((git-commit-major-mode . git-commit-elisp-text-mode)))
 '(scroll-error-top-bottom t)
 '(scroll-preserve-screen-position t)
 '(show-paren-mode t)
 '(truncate-lines t)
 '(vterm-max-scrollback 8192)

 ;; Company.
 '(company-dabbrev-code-ignore-case t)
 '(company-dabbrev-ignore-case t)
 '(company-etags-ignore-case t)
 '(company-keywords-ignore-case t)
 '(company-tooltip-align-annotations t)

 ;; Dired.
 '(dired-auto-revert-buffer t)
 '(dired-create-destination-dirs 'ask)
 '(dired-dwim-target t)
 '(dired-hide-details-hide-symlink-targets nil)
 '(dired-listing-switches "-alh")
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'top)

 ;; Global minor modes.
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(global-subword-mode t)
 '(popwin-mode t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(yas-global-mode t)

 ;; Ido
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido))

 ;; Markdown
 '(markdown-preview-http-port 9268)
 '(markdown-preview-stylesheets
   '("https://thomasf.github.io/solarized-css/solarized-dark.min.css")))

(defalias 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Manually load modules.
;;
;; TODO: Isn't there a way to use this snippet?
;;
;; (let ((dir "~/dotFiles/emacs/modules/"))
;;   (mapcar (lambda (path)
;;             (let ((symbol (intern (file-name-base path))))
;; 	      (message "[Y] Requiring %20s from %s" symbol path)
;;               (use-package symbol dir)))
;; 	  (directory-files dir t "^d-.*\\.el$")))

(d:use-package d-theme "~/dotFiles/emacs/modules")

(provide 'd-init)
