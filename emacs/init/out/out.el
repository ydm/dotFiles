;; =========================
;; init-advice
;; =========================

;; ;; Apply ANSI colors to the shell output buffer
;; (defadvice display-message-or-buffer
;;   (before y:ansi-color-apply-on-shell-output activate)
;;   (let ((buffer (ad-get-arg 0)))
;;     (and (bufferp buffer)
;;          (string= (buffer-name buffer) "*Shell Command Output*")
;;          (y:ansi-color-apply-on-buffer buffer))))

;; (defadvice ido-find-file
;;   (after y:sudo-ff-if-not-writable-or-diff-owner activate)
;;   "Reopen file as root unless:
;; 1) The file is already writable.
;; 2) The file is not writable, but the owner is the same as the current
;;    user.
;; 3) The file is hosted on a remote machine.
;; Original idea: http://bit.ly/KkqrNN"
;;   (unless (or (file-writable-p (buffer-file-name))
;;               (y:same-owner-p (buffer-file-name))
;;               (string-match "@" (buffer-file-name)))
;;     (if (y-or-n-p "Open file for editing?")
;;         (find-alternate-file
;;          (concat "/sudo:root@localhost:" buffer-file-name)))))

;; Pep8 requires tramp to work properly >.<
;; (defadvice pep8 (before y:load-tramp-before-pep8 activate)
;;   (require 'tramp))
