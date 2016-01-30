;; Add this in post.el
;; (require 'company-rtags)
;; (add-to-list 'company-backends #'company-rtags)
;; (global-set-key (kbd "M-.") #'y:my-rtags-find-symbol-at-point)

(custom-set-variables
 '(company-rtags-use-async nil))

(defun y:my-rtags-find-symbol-at-point (&optional prefix)
  "This is the original function but modified to search in more
places."
  (interactive "P")
  (rtags-delete-rtags-windows)
  (rtags-location-stack-push)
  (let ((arg (rtags-current-location))
        (tagname (or (rtags-current-symbol) (rtags-current-token)))
        (fn (buffer-file-name)))
    (rtags-reparse-file-if-needed)
    (with-current-buffer (rtags-get-buffer)
      (rtags-call-rc :path fn :path-filter prefix "-f" arg)
      (cond ((or (not rtags-follow-symbol-try-harder)
                 (= (length tagname) 0))
             (rtags-handle-results-buffer nil nil fn))
            ((rtags-handle-results-buffer nil t fn))
            (t
             (erase-buffer)
             (rtags-call-rc :path fn "-F" tagname "--definition-only" "-M" "1" :path-filter prefix
                            (when rtags-wildcard-symbol-names "--wildcard-symbol-names")
                            (when rtags-symbolnames-case-insensitive "-I"))
             (unless (rtags-handle-results-buffer nil nil fn)
               (erase-buffer)
               (rtags-call-rc :path fn "-F" tagname "-M" "1" :path-filter prefix
                              (when rtags-wildcard-symbol-names "--wildcard-symbol-names")
                              (when rtags-symbolnames-case-insensitive "-I"))
               (rtags-handle-results-buffer nil nil fn)))))))

(provide 'init-rtags)
