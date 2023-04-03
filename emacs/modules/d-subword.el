;; Enable `subword-mode' and change the :lighter.
(use-package subword
  :config
  (define-minor-mode subword-mode
    ""
    :lighter ""
    (when subword-mode (superword-mode -1))
    (subword-setup-buffer))
  :custom (global-subword-mode t))

(provide 'd-subword)
