;; Add (load "/home/y/dotFiles/emacs/y-init.el") to the TOP of .emacs

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
;;
;; y: Commented out.  I think package is now automatically
;;    initialized.  I should double-check.


;; +---------+
;; | General |
;; +---------+

(custom-set-variables
 '(backup-directory-alist '(("." . "~/.emacs.d/backup")))
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(company-tooltip-align-annotations t)
 '(compilation-always-kill t)
 '(compilation-scroll-output 'first-error)
 '(default-input-method "bulgarian-alt-phonetic")
 '(delete-selection-mode t)
 '(dired-auto-revert-buffer t)
 '(dired-create-destination-dirs 'ask)
 '(dired-dwim-target t)
 '(dired-hide-details-hide-symlink-targets nil)
 '(dired-listing-switches "-alh")
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'top)
 '(gc-cons-threshold 1600000)
 '(gdb-many-windows t)
 '(global-display-line-numbers-mode t)
 '(global-subword-mode t)
 '(helm-mode t)
 '(hs-hide-comments-when-hiding-all nil)
 '(image-dired-thumb-size 150)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mouse-yank-at-point t)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(safe-local-variable-values '((git-commit-major-mode . git-commit-elisp-text-mode)))
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(scroll-preserve-screen-position t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(yas-global-mode t))

(defalias 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)

;; +---------+
;; | Modules |
;; +---------+

(defvar *d:selected-packages* '())

(defmacro d:module (assoc &rest body)
  "Execute the module body after Emacs initializes.

If there are packages needed to be installed as dependencies for this
module to work, they may be specified in ASSOC.

There's also an optional hook variable this module can specify
that gets ran after the execution of BODY.  This way another actor may
use this module as a dependency.

ASSOC is an association list that may optionally provide the
following keys:
- hookvar: hook variable to run a hook on once the module body gets
           executed
- packages: packages to install on booting

(d:module
 '((packages challenger-theme)
   (hookvar . d-theme-hook))
  BODY...)
"
  `(progn
     ;; Add the packages prop 
     (mapcar (lambda (x) (add-to-list '*d:selected-packages* x))
             (cdr (assoc 'packages ,assoc)))
     (add-hook 'after-init-hook
               (lambda ()
                 ,@body
                 (let ((hookvar (cdr (assoc 'hookvar ,assoc))))
                   (and hookvar (run-hooks hookvar)))))))

(let ((dir "~/dotFiles/emacs/modules/"))
  (mapcar (lambda (path)
            (let ((symbol (intern (file-name-base path))))
	      (message "[Y] Requiring %20s from %s" symbol path)
	      (require symbol path)))
	  (directory-files dir t "^d-.*\\.el$")))


;; +------+
;; | Boot |
;; +------+

(require 'package)

(defun d:boot ()
  (let ((xs (seq-remove #'package-installed-p *d:selected-packages*)))
    (when xs
      (package-refresh-contents)
      (mapcar #'package-install xs)))
  (load "~/.emacs.d/init/post" t))

;; Registered last means to get executed first.
(add-hook 'after-init-hook #'d:boot)

(provide 'd-init)
