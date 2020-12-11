;; ;; Style should be either "chaos" or "ydm"
;; (let ((style "chaos"))
;;    (add-to-list 'c-default-style `(c++-mode . ,style))
;;    (add-to-list 'c-default-style `(c-mode . ,style)))

;; ;; rtags
;; (require 'company-rtags)
;; (add-to-list 'company-backends #'company-rtags)
;; (global-set-key (kbd "M-.") #'y:rtags-find-symbol-at-point)

;; ;; Global Yasnippet
;; (require 'yasnippet)
;; (yas-global-mode 1)

;; ;; Nyan cat!
;; (nyan-mode)
;; (nyan-start-animation)
