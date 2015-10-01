(require 'init-dsp)
(require 'init-gcc)

(add-to-list '*y:packages* 'company)
(add-to-list '*y:packages* 'company-c-headers)

(eval-after-load 'company
  (lambda ()
    (delete 'comapny-cmake company-backends)
    (delete 'company-bbdb company-backends)
    (delete 'company-css company-backends)
    (delete 'company-dabbrev company-backends)
    (delete 'company-eclim company-backends)
    (delete 'company-nxml company-backends)
    (delete 'company-oddmuse company-backends)
    (delete 'company-semantic company-backends)
    (delete 'company-xcode company-backends)
    (add-to-list 'company-backends 'company-c-headers)))

(defun y:company-set-include-paths ()
  (let* ((syst (y:gcc-system-include-dirs "clang"))
	 (user (y:dsp-parse-includes-for-file))
	 (dirs (append syst user)))
    (setq company-c-headers-path-system syst)
    (setq company-c-headers-path-user user)
    (setq company-clang-arguments (mapcar (lambda (d) (concat "-I" d)) dirs))))

(add-hook 'after-init-hook (lambda () (global-company-mode 1)))
(add-hook 'c++-mode-hook #'y:company-set-include-paths)

(provide 'init-company)
