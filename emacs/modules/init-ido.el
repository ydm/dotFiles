(require 'ido)

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key
              ido-file-dir-completion-map
              (kbd "M-DEL")
              'ido-up-directory)))

(provide 'init-ido)
