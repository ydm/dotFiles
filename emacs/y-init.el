;; Add (require 'y-init "~/dotFiles/emacs/y-init.el") to the end of
;; ~/.emacs (or at least after custom-set-variables)

(custom-set-variables
 '(backup-directory-alist '(("." . "~/.~")))
 '(global-display-line-numbers-mode t)
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido))
 '(inhibit-startup-screen t)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
(put 'dired-find-alternate-file 'disabled nil)

(require 'package)

(defun y:select-package (p)
  (unless (package--user-selected-p p)
    (add-to-list 'package-selected-packages p)))

(defmacro y:module (packages &rest body)
  `(progn
     (mapcar #'y:select-package ,packages)
     (add-hook 'after-init-hook (lambda () ,(cons 'progn body)))))

(let ((dir "~/dotFiles/emacs/modules/"))
  (mapcar (lambda (p)
	    (message "[Y] Requiring %s" p)
	    (require (intern (file-name-base p)) p))
	  (directory-files dir t "\\.el$")))

(defun y:all (xs)
  (cond ((null xs) t)
	((not (car xs)) nil)
	(t (y:all (cdr xs)))))

(defun y:install-packages ()
  (unless package--initialized (package-initialize t))
  (when (not (y:all (mapcar #'package-installed-p package-selected-packages)))
    (package-refresh-contents)
    (package-install-selected-packages)))

;; Registering last means executing first.
(add-hook 'after-init-hook #'y:install-packages)
	
(provide 'y-init)
