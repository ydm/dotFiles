(require 'cl)
(require 'dired)
(require 'dired-x)

;; Dired: allow nav in dired buffer.
(put 'dired-find-alternate-file 'disabled nil)

;; Dired-x: ignore certain files from listing.
(cl-delete ".so" dired-omit-extensions)
(add-hook 'dired-mode-hook
          (lambda () (dired-omit-mode 1)))

;; New dired commands: / and ^
(define-key dired-mode-map (kbd "/")
  (lambda (regexp)
    (interactive "sFind-grep (grep regexp): ")
    (find-grep-dired default-directory regexp)))
(define-key dired-mode-map (kbd "^")
  (lambda ()
    (interactive)
    (find-alternate-file "..")))

(provide 'init-dired)
