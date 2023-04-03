;; -*- lexical-binding: t; -*-


(defun d:keychords/switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))


(d:module
 '((packages ace-jump-mode ace-window key-chord))

 (key-chord-mode 1)
 (key-chord-define-global "ww" #'ace-window)
 (key-chord-define-global "hh" #'ace-jump-mode)
 (key-chord-define-global "vv" #'ido-switch-buffer)
 (key-chord-define-global "jj" #'d:keychords/switch-to-last-buffer))


(provide 'd-keychords)
