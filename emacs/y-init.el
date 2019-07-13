;; +---------+
;; | General |
;; +---------+

;; Add (require 'y-init "~/dotFiles/emacs/y-init.el") to the end of
;; ~/.emacs (or at least after custom-set-variables)

(custom-set-variables
 '(backup-directory-alist '(("." . "~/.~")))
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(company-tooltip-align-annotations t)
 '(default-input-method "bulgarian-alt-phonetic")
 '(delete-selection-mode t)
 '(dired-dwim-target t)
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
 '(show-paren-mode t))

(defalias 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)


;; +---------+
;; | Modules |
;; +---------+

(require 'package)

(defun y:select-package (p)
  (unless (package--user-selected-p p)
    (add-to-list 'package-selected-packages p)))

(defmacro y:module (packages &rest body)
  `(progn
     (mapcar #'y:select-package ,packages)
     (add-hook 'after-init-hook (lambda () ,(cons 'progn body)))))

;; TODO: Un-hard-code the path?
(let ((dir "~/dotFiles/emacs/modules/"))
  (mapcar (lambda (p)
	    (message "[Y] Requiring %s" p)
	    (require (intern (file-name-base p)) p))
	  (directory-files dir t "\\.el$")))

(defun y:all (xs)
  (cond ((null xs) t)
	((not (car xs)) nil)
	(t (y:all (cdr xs)))))

(defun y:installed-p (p)
  ;; (unless package--initialized (package-initialize t))
  (let ((installed (package-installed-p p)))
    (message "[Y] Package '%s' is %sinstalled" p (if installed "" "not "))
    installed))

(defun y:install-packages ()
  (unless package--initialized (package-initialize t))
  (when (not (y:all (mapcar #'y:installed-p package-selected-packages)))
    (package-refresh-contents)
    (package-install-selected-packages)))

(defun y:boot ()
  (y:install-packages)
  (let ((post "~/.emacs.d/init/post.el"))
    (when (file-exists-p post)
      (message "[Y] Loading %s" post)
      (load post))))

;; Registered last means executed first.
(add-hook 'after-init-hook #'y:boot)

(provide 'y-init)
