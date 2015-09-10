(add-to-list '*y:packages* 'company)
;; (add-to-list '*y:packages* 'company-c-headers)

(add-to-list '*y:packages* 'company-irony)
(add-to-list '*y:packages* 'company-irony-c-headers)

(eval-after-load 'company
  (lambda ()
    (message "LOADING IRONY")
    (add-to-list 'company-backends 'company-irony)
    (add-to-list 'company-backends 'company-irony-c-headers)))

(add-hook 'after-init-hook
	  (lambda ()
	    (global-company-mode 1)))

(provide 'init-company)
