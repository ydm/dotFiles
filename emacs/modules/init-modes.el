(y:install-packages cmake-mode glsl-mode)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (push '("/=" . ?≠) prettify-symbols-alist)
	    (push '("<=" . ?≤) prettify-symbols-alist)
	    (push '(">=" . ?≥) prettify-symbols-alist)
	    (push '("function" . ?ƒ) prettify-symbols-alist)
	    (push '("nil" . ?∅) prettify-symbols-alist)))

(custom-set-variables
 '(global-prettify-symbols-mode t))

(provide 'init-modes)
