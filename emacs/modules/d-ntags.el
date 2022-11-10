;; -*- lexical-binding: t; -*-


(d:module
 '((packages nim-mode))

 (defun d:ntags-find-definition (&optional prefix)
   (interactive "P")
   (d:load-library "interactives")
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
       (progn (find-file filename)
              (goto-char (save-mark-and-excursion
                           (goto-line lineno)
                           (back-to-indentation)
                           (point)))
              (recenter-top-bottom)
              (and prefix (message "[NTAGS] Command: %s" command)))
     (message "[NTAGS] Could not find definition: root=%s thing=%s command=%s output=%s parts=%s filename=%s line=%s"
              root thing command output parts filename line)))

 (require 'nim-mode)
 (define-key nim-mode-map (kbd "M-.") #'d:ntags-find-definition))


(provide 'd-ntags)
