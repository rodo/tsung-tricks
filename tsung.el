;;
;; find and open the newest tsung.log files
;;
(defun tsung-open-last-log ()
  "Open the last created tsung.log file"
  (interactive)
  (view-file
   (concat
    (car 
     (reverse 
      (sort 
       (directory-files "~/.tsung/log/" 
			'FULL 
			(rx bol (repeat 8 digit) "-" (repeat 4 digit) eol)) 'string-lessp)
      ))
    "/tsung.log")
   )
  )


