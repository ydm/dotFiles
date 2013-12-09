(require 'dired-x)
(require 'dired)

;; Dependencies:
;;   dired:
;;     dired-find-alternate-file
;;   dired-x:
;;     dired-omit-files

(put 'dired-find-alternate-file 'disabled nil) ; Allow nav in dired buffer

(defun y:dired-reuse-buffer-on-up ()
  (define-key dired-mode-map (kbd "^")
    (lambda ()
      (interactive)
      (find-alternate-file ".."))))

;; Ignore certain files from listing
(setq-default dired-omit-files-p t)
(add-to-list 'dired-omit-extensions ".pyc")

(provide 'init-dired)
