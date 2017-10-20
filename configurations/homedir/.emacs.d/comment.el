;; 
;; comment.el -- Gestion des commentaires independamment du mode
;; 
;; Author          : Prout
;; Created On      : Sun Oct 30 18:38:40 1994
;; Last Modified By: Max from LDE OBJEcTifS
;; Last Modified On: Wed May  3 16:13:36 1995
;; Update Count    : 27
;; Status          : Unknown, Use with caution!
;;

;(defun indent-region-2 (start end)
;  "Indent region between START and END.
;Return END."
;  (interactive "r")
;  (save-excursion
;    (let ((lines (count-lines start end)))
;      (if (> start end)
;	  (setq lines start start end end lines)
;	)
      
;      (goto-char start)
;      (while (/= 0 lines)
;	(indent-according-to-mode)
;	(forward-line)
;	(setq lines (1- lines))
;	)
;      )
;    )
;  end
;  )

(defun indent-buffer ()
  "Indent current buffer using indent-region-2 function.
Return \(point-max)."
  (interactive)
  (indent-region (point-min) (point-max) nil)
  )

(defun draw-comment-line (&optional num)
  "Draw a comment line: +---- NUM ----+
NUM is optional.
Works in all emacs modes."
  (interactive)
  (beginning-of-line)
  (if (string= comment-start ";")
      (insert ";; +")
    (insert comment-start " +"))
  (if (null num)
      (setq num (- fill-column (length comment-start) (length comment-end) 4)))
  (insert-char ?\- num)
  (if (= 0 (length comment-end))
      (insert "+")
    (insert "+ " comment-end))
  (indent-according-to-mode)
  (newline)
  (indent-according-to-mode)
  )

(defun comment-line ()
  "Comment line.
Works in all emacs modes."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t")
    (if (string= comment-start ";")
	(insert ";; ")
      (insert comment-start " "))
    (if (/= 0 (length comment-end))
	(progn
	  (end-of-line)
	  (insert " " comment-end)))
    (indent-according-to-mode)
    )
  )

(defun comment-paragraph ()
  "Comment paragraph begins at the beginning of the current line.
Warning in C Language with comments included in other comments...
Work in all emacs modes."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (/= 0 (length comment-end))
	;; On a juste a encadrer le paragraphe
	(let ((begin (point)))
	  (skip-chars-forward " \t")
	  (insert comment-start " ")
	  (forward-paragraph)
	  (insert " " comment-end)
	  (indent-region begin (point) nil)
	  )
      ;; Il faut commenter chaque ligne
      (let ((begin (point))
	    (lines (count-lines (point) (progn (forward-paragraph) (point)))))
	(goto-char begin)
	(while (/= 0 lines)
	  (comment-line)
	  (forward-line)
	  (setq lines (1- lines))
	  )
	)
      )
    )
  )

(defun remove-comment ()
  "Remove comment on the current line.
Work in all emacs modes."
  (interactive)
  (save-excursion
    (let ((end-line (progn (end-of-line) (point))))
      (beginning-of-line)
      (if (not (search-forward comment-start end-line t))
	  (message "No comment start (%s) found on this line..." comment-start)
	(delete-backward-char (length comment-start) nil)
	(if (/= 0 (length comment-end))
	    ;; Un commentaire de fin
	    (progn
	      (setq end-line (point))
	      (if (search-forward comment-end (point-max) t)
		  (progn
		    (delete-backward-char (length comment-end) nil)
		    (indent-region end-line (point) nil)
		    )
		)
	      )

	  ;; Pas de commentaire de fin
	  (while (looking-at comment-start)
	    (delete-char 1 nil))
	  (indent-according-to-mode)
	  )
	)
      )
    )
  )

(provide 'comment)
