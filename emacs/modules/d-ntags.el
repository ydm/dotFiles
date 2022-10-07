(y:module
 '((packages markdown-mode nim-mode))

 (defun d:ntags-find-definition ()
   (interactive)
   (d:load-library "interactives")
   (if-let* ((root (d:project-root))
             (thing (thing-at-point 'symbol))
             (command (format "/home/d/dev/ntags/server.py %s --tag %s" root thing))
             (output (shell-command-to-string command))
             (parts (split-string output ":"))
             (filename (car parts))
             (line (cadr parts))
             (lineno (string-to-number line)))
       (progn (find-file filename)
              (goto-char
               (save-mark-and-excursion
                 (goto-line (1+ lineno))
                 (back-to-indentation)
                 (point))))
     (message "[NTAGS] Could not find definition: root=%s thing=%s command=%s output=%s parts=%s filename=%s line=%s"
              root thing command output parts filename line)))

 (require 'nim-mode)
 (define-key nim-mode-map (kbd "M-.") #'d:ntags-find-definition))

(provide 'd-ntags)
