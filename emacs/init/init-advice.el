(require 'init-interactives)

;; Dependencies:
;;   init-interactives:
;;     (y:kill-system-buffers)

;; Clean up the buffer list when displaying the BS window
(defadvice bs-show (before y:kill-system-buffers-before-bs-show activate)
  (y:kill-system-buffers))

(provide 'init-advice)
