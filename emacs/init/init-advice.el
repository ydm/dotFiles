(require 'init-interactives)
(require 'init-defuns)

;; Dependencies:
;;   init-interactives:
;;     y:kill-system-buffers
;;   init-defuns:
;;     y:ansi-color-apply-on-buffer
;;     y:same-owner-p

;; Clean up the buffer list when displaying the BS window
(defadvice bs-show (before y:kill-system-buffers-before-bs-show activate)
  (y:kill-system-buffers))

;; Apply ansi color to the shell output buffer
(defadvice display-message-or-buffer
  (before y:ansi-color-apply-on-shell-output activate)
  (let ((buffer (ad-get-arg 0)))
    (and (bufferp buffer)
         (string= (buffer-name buffer) "*Shell Command Output*")
         (y:ansi-color-apply-on-buffer buffer))))

(defadvice ido-find-file
  (after y:sudo-ff-if-not-writable-or-diff-owner activate)
  "Reopen file as root if it's not writable or file's owner is
different.  Idea:
http://emacsredux.com/blog/2013/04/21/edit-files-as-root/"
  (unless (or (file-writable-p (buffer-file-name))
             (y:same-owner-p (buffer-file-name)))
    (if (y-or-n-p "Open file for editing?")
        (find-alternate-file
         (concat "/sudo:root@localhost:" buffer-file-name)))))

;; Pep8 requires tramp to work properly >.<
(defadvice pep8 (before y:load-tramp-before-pep8 activate)
  (require 'tramp))

(provide 'init-advice)
