;; Add these lines in your post.el:
;; (require 'company-nrtags)
;; (add-to-list 'company-backends #'company-rtags)

(defun y:init-rtags ()
  (rtags-start-process-unless-running)
  (rtags-enable-standard-keybindings))

(global-set-key (kbd "C-c r ;") (function rtags-find-file))

(add-hook 'c-mode-common-hook #'y:init-rtags)
(add-hook 'c++-mode-common-hook #'y:init-rtags)

;; This makes it easier to debug problems.
(custom-set-variables
 '(company-rtags-use-async nil))

(provide 'init-rtags)
