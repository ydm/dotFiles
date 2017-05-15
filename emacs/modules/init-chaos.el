(defun y:vray-render-vrscene ()
  "Renders a V-Ray scene using V-Ray Standalone"
  (interactive)
  (let* ((vray "/usr/autodesk/maya2016/vray/bin/vray")
	 (scene (buffer-file-name))
         (cmd (format "%s -numThreads=0 -sceneFile=%s 1>/tmp/vray.log 2>&1 &" vray scene)))
	 ;; (cmd (format "%s -sceneFile=%s -imgFile=/tmp/output.png &" vray scene)))
    (shell-command cmd)))

(provide 'init-chaos)
