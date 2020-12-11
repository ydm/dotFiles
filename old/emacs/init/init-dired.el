(require 'dired-x)
(require 'dired)

;; Dependencies:
;;   dired:
;;     'dired-find-alternate-file
;;   dired-x:
;;     'dired-omit-extensions
;;     'dired-omit-files-p

;; Allow nav in dired buffer
(put 'dired-find-alternate-file 'disabled nil)

;; Ignore certain files from listing
(setq-default dired-omit-files-p t)
(add-to-list 'dired-omit-extensions ".pyc")

(provide 'init-dired)
