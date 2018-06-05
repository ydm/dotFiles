(y:install-packages company)

;; The default company-backends list is full of backends that I
;; personally do not find valuable.  Here we start fresh with just
;; company-files.

;; The default company-backends is quite stuffed.  Here I reduce it to
;; include company-files only.
(add-hook 'after-init-hook
          (lambda ()
            (global-company-mode 1)
            ;; (setq company-backends '(company-files))
            ))

(provide 'init-company)
