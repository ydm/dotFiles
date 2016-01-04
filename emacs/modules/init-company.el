(add-to-list '*y:packages* 'company)

(eval-after-load 'company
  (lambda ()
    (setq company-backends '(company-files))))

(add-hook 'after-init-hook (lambda () (global-company-mode 1)))

;; (require 'init-dsp)
;; (require 'init-gcc)

;; (add-to-list '*y:packages* 'company-c-headers)

;; (defvar *y:company-clang-hard-coded-flags*
;;   '("-DLINUX"
;;     "-fpermissive"
;;     "-std=c++1y"
;;     "-include/usr/include/GL/gl.h"
;;     "-I/usr/include/qt4"))

;; (defun y:company-set-include-paths ()
;;   (let* ((syst (y:gcc-system-include-dirs "clang"))
;; 	 (user (y:dsp-parse-includes-for-file))
;; 	 (dirs (append syst user)))
;;     (setq company-c-headers-path-system syst)
;;     (setq company-c-headers-path-user user)
;;     (setq company-clang-arguments
;; 	  (append
;; 	   (mapcar (lambda (d) (concat "-I" d)) dirs)
;; 	   *y:company-clang-hard-coded-flags*))))

;; (add-hook 'c++-mode-hook #'y:company-set-include-paths)

(provide 'init-company)
