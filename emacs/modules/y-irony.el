;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; (add-hook 'c++-mode-hook 
;;           (lambda ()
;;             (define-key c++-mode-map (kbd "C-.") #'completion-at-point))
;;           (flycheck-mode 1))

(provide 'y-irony)

