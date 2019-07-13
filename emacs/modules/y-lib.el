(defun y:project-root ()
  "Copy of (ffip-project-root), but returns nil if there's no
project root found.  The standard (ffip-project-root) returns
default-directory instead."
  (let* ((project-root (or ffip-project-root
                           (cond
                            ((functionp ffip-project-root-function)
                             (funcall ffip-project-root-function))
                            ((listp ffip-project-file)
                             (ffip--some (apply-partially
                                          #'locate-dominating-file
                                          default-directory)
                                         ffip-project-file))
                            (t
                             (locate-dominating-file default-directory
                                                     ffip-project-file))))))
    project-root))

(provide 'y-lib)
