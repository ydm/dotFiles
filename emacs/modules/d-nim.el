;; -*- lexical-binding: t; -*-

(use-package d-common :load-path "~/dotFiles/emacs/libraries") ; d:project-root

(defun d:nim-ntags-find-definition (&optional prefix)
  (interactive "P")
  (if-let* ((root (d:project-root))
            (thing (thing-at-point 'symbol))
            (current-file (buffer-file-name))
            (update (if prefix "--update" ""))
            (command
             (format
              "/home/d/dotFiles/wannabin/ntagsserver.py --current-file %s %s --tag %s %s"
              current-file
              update
              thing
              root))
            (output (shell-command-to-string command))
            (parts (split-string output ":"))
            (filename (car parts))
            (line (cadr parts))
            (lineno (string-to-number line)))
      (progn (message "[X] command=%s" command)
             (find-file filename)
             (goto-char (save-mark-and-excursion
                          (goto-line lineno)
                          (back-to-indentation)
                          (point)))
             (recenter-top-bottom)
             (and prefix (message "[NTAGS] Command: %s" command)))
    (message "[NTAGS] Could not find definition: root=%s thing=%s command=%s output=%s parts=%s filename=%s line=%s"
             root thing command output parts filename line)))

(use-package nim-mode
  :config
  (add-hook 'nim-mode-hook
            (lambda ()
              (eldoc-mode -1)
              (which-function-mode 1)))
  :bind (:map nim-mode-map
              ("M-." . d:nim-ntags-find-definition))
  :ensure t)

(use-package highlight-indent-guides
  :hook nim-mode
  :custom
  (highlight-indent-guides-method 'column)
  :ensure t)

(provide 'd-nim)
