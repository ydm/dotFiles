(add-to-list '*y:packages* 'auto-complete)
(add-to-list '*y:packages* 'auto-complete-c-headers)
(add-to-list '*y:packages* 'auto-complete-clang)

(defun y:init-ac-sources-cpp ()
  (message "y:init-ac-sources-cpp")
  ;; (semantic-mode 1)
  ;; (add-to-list 'ac-sources 'ac-source-semantic)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-clang))

(defun y:init-ac ()
  (message "y:init-ac")
  
  (require 'auto-complete-config)
  (require 'auto-complete-c-headers)
  (require 'auto-complete-clang)
  ;; (require 'semantic)

  (ac-config-default)
  (add-to-list 'ac-dictionary-directories
	       "~/dotFiles/emacs/modules/init-ac/dicts")
  ;; (add-to-list 'c++-mode-hook #'y:init-ac-sources-cpp)
  (add-hook 'c-mode-common-hook #'y:init-ac-sources-cpp))

(add-hook 'after-init-hook #'y:init-ac)
(provide 'init-ac)
