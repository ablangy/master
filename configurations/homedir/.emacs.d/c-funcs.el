;;
;; c.el -- Fonctions specifiques au c-mode
;;
;; Author          : Prout
;; Created On      : Sun Oct 30 13:39:12 1994
;; Last Modified By: Prout
;; Last Modified On: Sat Dec  3 23:05:30 1994
;; Update Count    : 17
;; Status          : Unknown, Use with caution!
;;

(provide 'c-funcs)

(defun c-debug-line ()
  "Insert a debug line in c code"
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (insert-string "printf(\"[%s]: %s\\n\",__FILE__,__LINE__);\n")
  )

(defun c-include (start stop)
  (let ((ok t)(includename ""))
    (beginning-of-line)
    (while ok
      (setq includename
	    (read-from-minibuffer (concat "[RETURN to quit] #include " start)))
      
      (if (or (= 0 (length includename)) (< 66 (length includename)))
	  (setq ok nil)
	(insert-string (concat "#include " start includename ".h" stop "\n"))
	)
      )
    )
  )

(defun c-system-include ()
  "Insert a system include line, like this: #include <stdio.h>"
  (interactive)
  (c-include "<" ">")
  )

(defun c-user-include ()
  "Insert an user include line, like this: #include \"defs.h\""
  (interactive)
  (c-include "\"" "\"")
  )

(defun open-include ()
  "Get the file referenced in the #include directive on the current line
and opens it in an other window.
Made by Roger B. J. Baron, November 27th, 1992."
  (interactive)
  (let (prefix start end)
    (save-excursion
      (beginning-of-line)
      (let ( (pos (point) ))
	(forward-word 1)
	(if (not (string= "#include" (buffer-substring pos (point) )))
	    (error "There's no #include directive on this line !")
	  )
	)
      (skip-chars-forward " \t")
      (if (eq ?< (char-after (point)))
	  ;; "system" include file :
	  (setq prefix "/usr/include/")
	(setq prefix "")
	)
      (forward-char 1)
      (setq start (point))
      (skip-chars-forward "^\">")
      (setq end (point))
      )					;save-excursion
    (find-file-other-window (concat prefix (buffer-substring start end)) )
    )					;let prefix...
  )					;defun open-cpp-include
