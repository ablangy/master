;;
;; myfct-compile.el -- 
;; 
;; Author          : Antoine BLANGY
;; Created On      : Thu Feb 21 17:58:52 2013
;; Last Modified By: Antoine BLANGY
;; Last Modified On: Thu Feb 21 18:15:57 2013
;; Update Count    : 13
;; Status          : Unknown, Use with caution!
;;
(defun myfct-compile ()
  (interactive)
  (byte-compile-file "~/.emacs.d/auto-template.el")
  (byte-compile-file "~/.emacs.d/c-funcs.el")
  (byte-compile-file "~/.emacs.d/comment.el")
  (byte-compile-file "~/.emacs.d/group.el")
  (byte-compile-file "~/.emacs.d/header2.el")
  (byte-compile-file "~/.emacs.d/variables.el")
  (byte-compile-file "~/.emacs.d/myfct.el")
)

(defun myfct-compile-clean ()
  (interactive)
  (delete-file "~/.emacs.d/auto-template.elc")
  (delete-file "~/.emacs.d/c-funcs.elc")
  (delete-file "~/.emacs.d/comment.elc")
  (delete-file "~/.emacs.d/group.elc")
  (delete-file "~/.emacs.d/header2.elc")
  (delete-file "~/.emacs.d/variables.elc")
  (delete-file "~/.emacs.d/myfct.elc")
)

(provide 'myfct)