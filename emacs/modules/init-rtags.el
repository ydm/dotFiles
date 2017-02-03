(y:install-packages flycheck)

(defun y:init-rtags ()
  (rtags-start-process-unless-running)
  (rtags-enable-standard-keybindings))

(add-hook 'after-init-hook
          (lambda ()
            (require 'company-rtags)
            (require 'flycheck-rtags)))

(add-hook 'c-mode-hook   #'y:init-rtags)
(add-hook 'c++-mode-hook #'y:init-rtags)

(global-set-key (kbd "C-c r ;") #'rtags-find-file)


;; This makes it easier to detect and debug any rtags problems.
;; '(company-rtags-use-async nil)
(custom-set-variables '(rtags-completions-enabled t))

(provide 'init-rtags)
;;; init-rtags.el ends here
