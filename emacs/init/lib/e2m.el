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
;;    (setq e2m/addr '("localhost" . 2222))
;;    (local-set-key (kbd "C-c C-c") 'e2m/send-buffer)
;;    (local-set-key (kbd "C-c C-z") 'e2m/display-buffer)))

(require 'comint)

(defcustom e2m/addr '("localhost" . 2222)
  "Default host/port on which Maya is running")

(defvar e2m/buffer nil
  "Buffer used for communication with Maya.")

(defun e2m/connect ()
  (let ((buf (make-comint "Maya" e2m/addr)))
    (set-process-query-on-exit-flag (get-buffer-process buf) nil)
    (with-current-buffer buf
      ;; (setq comint-prompt-regexp "^$")
      (add-hook 'comint-preoutput-filter-functions #'e2m/filter nil t))
    buf))

(defalias 'e2m/connectedp #'comint-check-proc)

(defun e2m/display-buffer ()
  (unless (e2m/connectedp e2m/buffer)
    (and e2m/buffer (kill-buffer e2m/buffer))
    (setq e2m/buffer (e2m/connect)))
  (display-buffer e2m/buffer))

(defun e2m/filter (s)
  (replace-regexp-in-string "\n " "" s))  

(defun e2m/send-buffer ()
  (interactive)
  (e2m/send-region (point-min) (point-max)))

(defun e2m/send-region (start end)
  (interactive "r")
  (e2m/display-buffer)
  (let ((tempfile (make-temp-file "e2m-")))
    (write-region start end tempfile)
    (with-current-buffer e2m/buffer
      (comint-simple-send (get-buffer-process e2m/buffer)
			  (format "source \"%s\"" tempfile)))
    (run-at-time 10 nil (lambda () (delete-file tempfile)))))

(provide 'e2m)
