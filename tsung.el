;;
;; find and open the newest tsung.log files
;;
(defconst tsung-log-dir "~/.tsung/log/")
(defconst tsung-logfilename "tsung.log")

(defun tsung-open-last-log ()
  "Open the last created tsung.log file"
  (interactive)
  (view-file
   (expand-file-name 
    tsung-logfilename 
    (car		       
     (directory-files tsung-log-dir 
		      'FULL 
		      (rx bol (repeat 8 digit) "-" (repeat 4 digit) eol))
     ))))
