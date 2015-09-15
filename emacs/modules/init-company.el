(add-to-list '*y:packages* 'company)
(add-to-list '*y:packages* 'company-c-headers)
;; (add-to-list '*y:packages* 'company-irony)
;; (add-to-list '*y:packages* 'company-irony-c-headers)

(eval-after-load 'company
  (lambda ()
    (add-to-list 'company-backends 'company-c-headers)))

(add-hook 'after-init-hook (lambda ()
			     (semantic-mode 1)
			     (global-company-mode 1)))
(provide 'init-company)
