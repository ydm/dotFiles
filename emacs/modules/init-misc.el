;; Miscellaneous functions and utilities

(defun y:cppfilt ()
  (interactive)
  (let* ((symbol (symbol-at-point))
         (cmd    (format "c++filt \"%s\"" symbol))
         (output (shell-command-to-string cmd)))
    (message output)))

(defun y:create-patch-from-buffers (a b)
  "Run Ediff on a pair of buffers, A B."
  (interactive
   (let (bf)
     (list (setq bf (read-buffer "Buffer A to compare: "
				 (ediff-other-buffer "") t))
	   (read-buffer "Buffer B to compare: "
			(progn
			  ;; Realign buffers so that two visible bufs
			  ;; will be at the top.
			  (save-window-excursion (other-window 1))
			  (ediff-other-buffer bf))
			t))))
  (let ((fa (buffer-file-name (get-buffer a)))
        (fb (buffer-file-name (get-buffer b))))
    (with-current-buffer-window (generate-new-buffer "Patch") nil nil
                                (toggle-read-only)
                                (setq buffer-read-only nil)
                                (insert (shell-command-to-string           
                                         (format "diff '%s' '%s'" fa fb))))))

(defun y:locate-breakpoint ()
  "When you ask gdb for your breakpoints, you may also want to
  locate them.  Well, in this case you ask this guy for help."
  (interactive)
  (let* ((str (buffer-substring-no-properties
               (line-beginning-position) (line-end-position)))
         (file-and-line (car (last (split-string str))))
         (split (split-string file-and-line ":"))
         (filename (car split))
         (lineno (string-to-number (cadr split))))
    (ffap filename)
    (goto-line lineno)))

(defun y:push-filename-line ()
  "Push the current buffer's filename:line into the kill ring."
  (interactive)
  (let* ((filename (buffer-file-name))
           (line (line-number-at-pos))
           (cmd (format "%s:%d" filename line)))
    (with-temp-buffer
      (insert cmd)
      (kill-ring-save (point-min) (point-max)))))

(provide 'init-misc)
