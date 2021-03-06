;;; e2m.el --- Emacs to Maya communication
;;
;; Copyright (C) 2015 Yordan Miladinov <jordanMiladinov@gmail.com>
;; Based on etom.el by Slavomir Kaslev <slavomir.kaslev@gmail.com>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;
;; This package is used for communication between Emacs and Maya.  You
;; can use it together with Shuji Narazaki's mel-mode to send pieces of
;; MEL code to Maya and get the results back in Emacs.
;;
;; To use this, insert the following in your ~/.emacs file:
;; (add-hook 'mel-mode-hook
;;  (lambda ()
;;    (require 'e2m)
;;    (setq e2m/addr '("localhost" . 2223))
;;    (local-set-key (kbd "C-c C-z") #'e2m/display-maya-buffer)))
;;    (local-set-key (kbd "C-c C-c") #'e2m/send-buffer)
;;    (local-set-key (kbd "C-c C-q") #'e2m/send-quick)
;;    (local-set-key (kbd "C-c C-v") #'e2m/send-line)
;;
;; You also need to execute the following on Maya:
;; commandPort -eo -n ":2223";
;; It's better if you add this to your userSetup.mel.

(require 'comint)

(defcustom e2m/addr '("localhost" . 2223)
  "Default host/port on which Maya is running")

(defvar e2m/buffer nil
  "Buffer-local variable used to store the side buffer for
  communication with Maya.  While not yet fully supported yet,
  this allows you to use mulitple Maya comints")

(defun e2m/connect ()
  (let ((buf (make-comint (e2m/maya-buffer-name) e2m/addr)))
    (set-process-query-on-exit-flag (get-buffer-process buf) nil)
    (with-current-buffer buf
      (add-hook 'comint-preoutput-filter-functions #'e2m/filter nil t))
    buf))

(defun e2m/connect2 ()
  (make-local-variable 'e2m/buffer)
  (unless (e2m/connectedp e2m/buffer)
    (and e2m/buffer (kill-buffer e2m/buffer))
    (setq e2m/buffer (e2m/connect))))

(defalias 'e2m/connectedp #'comint-check-proc)

(defun e2m/display-maya-buffer ()
  (interactive)
  (e2m/connect2)
  (display-buffer e2m/buffer)
  (when (called-interactively-p 'any)
    (select-window (get-buffer-window e2m/buffer))))

(defun e2m/filter (s)
  "Removes \n\0 from string S."
  (let ((rep (replace-regexp-in-string "\n " "" s)))
    (if (string-suffix-p "\n" rep)
	rep
      (format "%s\n" rep))))

(defun e2m/maya-buffer-name ()
  (format "maya:%s" (buffer-name (current-buffer))))

(defun e2m/send-buffer ()
  (interactive)
  (e2m/send-region (point-min) (point-max)))

(defun e2m/send-line ()
  (interactive)
  (save-excursion
    (e2m/send-region (thing-at-point 'line) nil)
    (beginning-of-line)
    (kill-line 1)))

(defun e2m/send-quick (cmd)
  (interactive "sMEL: ")
  (e2m/connect2)
  (comint-simple-send (get-buffer-process e2m/buffer) (format "%s;" cmd)))

(defun e2m/send-region (start end)
  (interactive "r")
  (e2m/display-maya-buffer)
  (let ((tempfile (make-temp-file "e2m-")))
    (write-region start end tempfile)
    (comint-simple-send (get-buffer-process e2m/buffer)
			(format "source \"%s\"" tempfile))
    (run-at-time 10 nil #'delete-file tempfile)))

;; (defun e2m/send-string (s)
;;   (interactive "r")
;;   (e2m/display-maya-buffer)
;;   (let ((tempfile (make-temp-file "e2m-")))
;;     (write-region start end tempfile)
;;     (comint-simple-send (get-buffer-process e2m/buffer)
;; 			(format "source \"%s\"" tempfile))
;;     (run-at-time 10 nil #'delete-file tempfile)))  

(provide 'e2m)
