;; Additional modes to install.
(y:install-packages
 cmake-mode
 flymake-haskell-multi
 glsl-mode
 haskell-mode
 yaml-mode)

;; Enable which-function-mode for C languages.
(add-hook 'c-mode-common-hook (lambda () (which-function-mode t)))

(defun y:init-modes/pretty (from to)
  (push (cons from to) prettify-symbols-alist))

;; Enable prettify-symbols-mode for Emacs Lisp and Haskell modes.
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (y:init-modes/pretty "/="       ?≠)
            (y:init-modes/pretty "/="       ?≠)
            (y:init-modes/pretty "<="       ?≤)
            (y:init-modes/pretty ">="       ?≥)
            (y:init-modes/pretty "function" ?ƒ)
            (y:init-modes/pretty "nil"      ?∅)))
(add-hook 'haskell-mode-hook
          (lambda ()
            (require 'flymake-haskell-multi)
            (flymake-haskell-multi-load)

            (y:init-modes/pretty "->"   ?→)
            ;; (y:init-modes/pretty "/"    ?÷)
            (y:init-modes/pretty "/="   ?≠)
            (y:init-modes/pretty "<="   ?≤)
            (y:init-modes/pretty ">="   ?≥)
            (y:init-modes/pretty "\\"   ?λ)
            (y:init-modes/pretty "pi"   ?π)
            (y:init-modes/pretty "sqrt" ?√)))
(custom-set-variables
 '(global-prettify-symbols-mode t))

(provide 'init-modes)
