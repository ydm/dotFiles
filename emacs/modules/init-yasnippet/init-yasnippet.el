(y:install-packages yasnippet)

(setq *y:init-yasnippet/file-name* load-file-name)

(eval-after-load 'yasnippet
  (lambda ()
    (let* ((dir (file-name-directory *y:init-yasnippet/file-name*))
	   (snippets (concat dir "snippets")))
      (add-to-list 'yas-snippet-dirs snippets))))

(add-hook 'after-init-hook (lambda () (yas-global-mode 1)))
(provide 'init-yasnippet)
