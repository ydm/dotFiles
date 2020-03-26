;; Add (load "/home/y/dotFiles/emacs/y-init.el") to the TOP of .emacs

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


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
 '(dired-dwim-target t)
 '(dired-listing-switches "-alh")
 '(gdb-many-windows t)
 '(global-display-line-numbers-mode t)
 '(global-subword-mode t)
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mouse-yank-at-point t)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(truncate-lines t))

(defalias 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)


;; +---------+
;; | Modules |
;; +---------+

(defvar *y:selected-packages* '())

(defmacro y:module (assoc &rest body)
  "ASSOC is an association list that may optionally provide the
following keys:
- hookvar: hook variable to run a hook on once the module body gets
           executed
- packages: packages to install on booting"
  `(progn
     ;; Add the packages prop 
     (mapcar (lambda (x) (add-to-list '*y:selected-packages* x))
             (cdr (assoc 'packages ,assoc)))
     (add-hook 'after-init-hook
               (lambda ()
                 ,@body
                 (let ((hookvar (cdr (assoc 'hookvar ,assoc))))
                   (and hookvar (run-hooks hookvar)))))))

;; XXX: Un-hard-code path?
(let ((dir "~/dotFiles/emacs/modules/"))
  (mapcar (lambda (p)
	    (message "[Y] Requiring %s" p)
	    (require (intern (file-name-base p)) p))
	  (directory-files dir t "\\.el$")))


;; +------+
;; | Boot |
;; +------+

(defun y:boot ()
  (let ((xs (seq-remove #'package-installed-p *y:selected-packages*)))
    (when xs
      (package-refresh-contents)
      (mapcar #'package-install xs)))
  (load "~/.emacs.d/init/post" t))

;; Registered last means executed first.
(add-hook 'after-init-hook #'y:boot)

(provide 'y-init)
