(y:install-packages company)

;; The default company-backends list is full of stupid backends that
;; do nothing valuable at all.  Here we start fresh with just
;; company-files.
(add-hook 'after-init-hook
          (lambda ()
            (global-company-mode 1)
            (setq company-backends '(company-files))))

(provide 'init-company)
