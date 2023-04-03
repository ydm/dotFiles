;; -*- lexical-binding: t -*-

(use-package company
  :hook prog-mode
  :custom
  (company-dabbrev-code-ignore-case t)
  (company-dabbrev-ignore-case t)
  (company-etags-ignore-case t)
  (company-keywords-ignore-case t)
  (company-lighter-base "cmp")
  (company-tooltip-align-annotations t)
  :ensure t)

(provide 'd-company)
