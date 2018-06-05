;; +--------+
;; | Python |
;; +--------+

(defvar y:python-last-run-buffer 'nil
  "The buffer that's last run by the (python-run) function.")

(defun y:python-run (&optional show-python-shell)
  (interactive)
  (let* ((dedicated-proc-name (python-shell-get-process-name t))
         (dedicated-proc-buffer-name (format "*%s*" dedicated-proc-name))
         (dedicated-running (comint-check-proc dedicated-proc-buffer-name)))
    ;; If there's already a python shell running for this buffer, kill it
    (when dedicated-running
      (let* ((process (python-shell-get-or-create-process))
             (buffer (process-buffer process)))
        (set-process-query-on-exit-flag process nil)
        (kill-buffer buffer)))

    ;; Set current buffer as the last run buffer
    (setq y:python-last-run-buffer (buffer-name (current-buffer)))

    ;; Start new python shell
    (run-python python-shell-interpreter t show-python-shell)
    (python-shell-send-buffer t)
    (select-window (selected-window))))

(defun y:python-run-main (&optional show-python-shell)
  (interactive)
  (let ((main (car (y:python-main-buffers
                    (if (local-variable-p 'run-by) run-by)))))
    (when main
      (with-current-buffer main
        (y:python-run show-python-shell)))))

(defun y:python-rerun (&optional show-python-shell)
  (interactive)
  (let ((buffer (y:get-buffer y:python-last-run-buffer)))
    (when buffer
      (with-current-buffer buffer
        (y:python-run show-python-shell)))))
