;; (y:install-packages flycheck)

(defun y:init-rtags ()
  (rtags-start-process-unless-running)
  (rtags-enable-standard-keybindings))

(add-hook 'after-init-hook
          (lambda ()
            (require 'company-rtags)
            ;; (require 'flycheck)
            ;; (require 'flycheck-rtags)
            (setq flycheck-checkers '(rtags))
            ))

(add-hook 'c-mode-common-hook   (function y:init-rtags))
(add-hook 'c++-mode-common-hook (function y:init-rtags))

(global-set-key (kbd "C-c r ;") (function rtags-find-file))

;; This makes it easier to detect and debug any rtags problems.
(custom-set-variables
 '(company-rtags-max-wait 1000)  ;; Hmm...
 '(company-rtags-use-async nil)
 '(rtags-completions-enabled t))

(provide 'init-rtags)
;;; init-rtags.el ends here
