(require 'init-defuns)
(require 'init-dired)

;; Dependencies:
;;   init-dired:
;;     (y:dired-reuse-buffer-on-up)
;;   init-defuns:
;;     (y:delete-trailing-ws-by-mode)
;;     (y:mkdir-for-buffer-file-name)

(defvar y:hook-config
  '((ansi-color-for-comint-mode-on (shell-mode-hook))
    (errnav-minor-mode (flymake-mode-hook))
    (flymake-jslint-load (js-mode-hook))
    (subword-mode (js-mode-hook))
    (y:delete-trailing-ws-by-mode (before-save-hook))
    (y:dired-reuse-buffer-on-up (dired-mode-hook))
    (y:mkdir-for-buffer-file-name (find-file-hook)))
  "Each entry of this list contains:
1) a function that will be hooked,
2) a list of hooks to bind the function to.")

(defun y:apply-hooks (e)
  (let ((func (car e))
        (hook-list (cadr e)))
    (mapcar (lambda (hook)
              ;; (message "(add-hook %s %s)" hook func)
              (add-hook hook func))
            hook-list)))
(mapcar #'y:apply-hooks y:hook-config)

;; Use web-mode for html documents and Django templates
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Enable global abbreviations
(setq-default abbrev-mode t)

;; Global modes
(add-hook 'after-init-hook
	  (lambda ()
	    (key-chord-mode 1)))

;; Use web-mode (instead of html-mode) for HTML files
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(provide 'init-modes)
