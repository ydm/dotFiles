(require 'dired-x)
(require 'dired)

;; Dired: allow nav in dired buffer.
(put 'dired-find-alternate-file 'disabled nil)

;; Dired-x: ignore certain files from listing.
(add-to-list 'dired-omit-extensions ".pyc")
(setq-default dired-omit-files-p t)

(provide 'init-dired)
