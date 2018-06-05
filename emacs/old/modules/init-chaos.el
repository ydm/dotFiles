(defun y:vray-render-vrscene ()
  "Renders a V-Ray scene using V-Ray Standalone"
  (interactive)
  (let* ((vray "/usr/autodesk/maya2017/vray/bin/vray")
	 (scene (buffer-file-name))
         (cmd (format (concat
                       "%s "
                       "-numThreads=1 "
                       "-sceneFile=%s "
                       "-imgFile=/tmp/output.png "
                       "2>&1 1>/tmp/vray.log "
                       "&")
                      vray scene)))
    (shell-command cmd)))

(defun y:debug-maya ()
  (interactive)
  (gdb "/usr/autodesk/maya2017/bin/maya -d gdb -dbgArg -i=mi"))

(provide 'init-chaos)
