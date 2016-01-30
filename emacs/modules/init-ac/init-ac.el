(add-to-list '*y:packages* '(init-ac auto-complete))
(add-to-list '*y:packages* '(init-ac auto-complete-c-headers))
(add-to-list '*y:packages* '(init-ac auto-complete-clang))
;; yasnippet works so nice with AC, I just have to include it here as
;; part of this module.  ;)
(add-to-list '*y:packages* 'yasnippet)

(defun y:init-ac-sources-cpp ()
  (setq ac-sources
	'(ac-source-c-headers
	  ac-source-clang
	  ac-source-yasnippet)))

(defun y:init-ac ()
  (require 'auto-complete-config)
  (require 'auto-complete-c-headers)
  (require 'auto-complete-clang)

  ;; Configure yasnippet
  (require 'yasnippet)
  (yas-global-mode 1)

  ;; Configure ac-sources
  (ac-config-default)
  (add-hook 'c++-mode-hook #'y:init-ac-sources-cpp)
  (add-to-list 'ac-dictionary-directories "~/dotFiles/emacs/modules/init-ac/dicts")
  (global-auto-complete-mode t))

(add-hook 'after-init-hook #'y:init-ac)
(provide 'init-ac)
