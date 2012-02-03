(defun set-frame-size-according-to-resolution ()
  ;; (interactive)
  (if window-system
      (progn
        (add-to-list 'default-frame-alist (cons 'width 120))
        (add-to-list 'default-frame-alist (cons 'height 50)))))
(set-frame-size-according-to-resolution)
