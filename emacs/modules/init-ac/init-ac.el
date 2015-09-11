(add-to-list '*y:packages* 'auto-complete)
(add-to-list '*y:packages* 'auto-complete-c-headers)

(defun y:ac-init-sources-c ()
  (semantic-mode 1)
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-semantic))

(defun y:init-ac ()
  (require 'auto-complete-config)
  (ac-config-default)
  (add-to-list 'ac-dictionary-directories
	       "~/dotFiles/emacs/modules/init-ac/dicts")
  (add-hook 'c-mode-common-hook #'y:ac-init-sources-c))

(add-hook 'after-init-hook #'y:init-ac)
(provide 'init-ac)
