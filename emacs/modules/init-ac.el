(add-to-list '*y:packages* 'auto-complete)
(add-to-list '*y:packages* 'auto-complete-c-headers)

(defun y:ac-init-sources-c ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-semantic))

(defun y:init-ac ()
  (require 'auto-complete-config)
  (ac-config-default)
  (add-hook 'c-mode-common-hook #'y:ac-init-sources-c))

(semantic-mode 1)
(add-hook 'after-init-hook #'y:init-ac)
(provide 'init-ac)
