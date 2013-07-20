(require 'dired)

;; Dependencies:
;;   dired:
;;     dired-find-alternate-file

(put 'dired-find-alternate-file 'disabled nil) ; Allow nav in dired buffer

(defun y:dired-reuse-buffer-on-up ()
  (define-key dired-mode-map (kbd "^")
    (lambda ()
      (interactive)
      (find-alternate-file ".."))))

(provide 'init-dired)
