(require 'dired-x)
(require 'dired)

;; Dired: allow nav in dired buffer.
(put 'dired-find-alternate-file 'disabled nil)

;; Dired-x: ignore certain files from listing.
(add-to-list 'dired-omit-extensions ".pyc")
(setq-default dired-omit-files-p t)

;; New dired commands mapped on keys
(define-key dired-mode-map (kbd "/")
  (lambda (regexp)
    (interactive "sFind-grep (grep regexp): ")
    (find-grep-dired default-directory regexp)))

(define-key dired-mode-map (kbd "^")
  (lambda ()
    (interactive)
    (find-alternate-file "..")))

(provide 'init-dired)
