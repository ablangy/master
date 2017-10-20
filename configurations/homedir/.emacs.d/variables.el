;;
;; variables.el -- Initialisation des variables globales
;; 
;; Author          : Prout
;; Created On      : Sun Oct 30 01:21:06 1994
;; Last Modified By: antoine
;; Last Modified On: Wed Feb 20 22:21:10 2013
;; Update Count    : 107
;; Status          : Unknown, Use with caution!
;;

(put 'eval-expression 'disabled nil)	; Evaluateur d'expression Lisp actif
(put 'upcase-region 'disabled nil)	; Passage region en majuscule actif
(put 'downcase-region 'disabled nil)	; Passage region en minuscule actif
(put 'narrow-to-region 'disabled nil)	; Masquage de region actif

(set-default 'mode-line-buffer-identification '("E~Max: %15b"))
(setq inhibit-startup-message t		; Pas de message de GNU au debut

      window-min-height 2		; Hauteur minimum avant suppression
      window-min-width 3		; Idem largeur
      truncate-partial-width-windows nil

      backup-by-copying-when-linked t	; Config des backup
      backup-by-copying-when-mismatch t

      shell-file-name "/bin/sh"		; Shell par defaut
      compile-command "make"		; Commande de compilation

      debug-on-error nil
      debug-on-quit nil
      
      next-line-add-newlines nil)	; Pas d'ajout de lignes avec fleche bas

;; Pour M-/    : conserve la casse...
(set-default 'dabbrev-case-fold-search nil)

;; Gestion automatique de l'update des headers
(add-hook 'write-file-hooks 'update-file-header)
(add-hook 'find-file-hooks 'auto-template)
(setq auto-template-loaded t)

;; Recherche des fichiers non trouves dans des chemins par defaut
;;(add-hook 'find-file-not-found-hooks 'find-file-using-paths-hook t)

;; Info, directory supplementaire
(setq Info-default-directory-list (append Info-default-directory-list
					  (list (concat obj-path "info")))
      ;; Le Man (voir fichier X-init.el)
      Man-overstrike-face	'man-bold
      Man-underline-face	'man-underline

      ;; Les News Internationales + mail
      mail-use-rfc822		  t
      mail-yank-prefix		  "|> "
      mail-signature		  nil

      gnus-local-domain		  "oceanis.net"
      gnus-local-organization	  "DotCom"
      gnus-default-article-saver  'gnus-summary-save-in-file
      gnus-article-save-directory "~/News/"
      gnus-save-all-headers	  nil
      gnus-thread-indent-level    2
      gnus-ignored-headers	  "^\\(To\\|Cc\\|Originator\\|Keywords\\|Path\\|Posting-Version\\|Article-I.D.\\|Expires\\|Date-Received\\|References\\|Control\\|Xref\\|Lines\\|Posted\\|Relay-Version\\|Message-ID\\|Nf-ID\\|Nf-From\\|Approved\\|Sender\\|X-[^:]*\\|NNTP-[^:]*\\|Mime-[^:]*\\|Content-Type\\|Content-Transfer-Encoding\\|In-[Rr]eply-to\\|Reply-To\\|Followup-to\\|Xdisclaimer\\|Summary\\|Function\\):"

      gnus-uu-user-view-rules	  '(("jpe?g$\\|gif$" "xli")
				    ("au$\\|voc$\\|wav$" nil))
      gnus-uu-do-not-unpack-archives t
      gnus-uu-view-and-save	  t
      gnus-uu-asynchronous	  t
      gnus-uu-ask-before-view	  t

      ;; Basculage des modes automatique
      auto-mode-alist
      (append 
       (list 
	'("\\.st\\'"		. smalltalk-mode)
	'("\\.m\\'"		. objc-mode)
	'("\\.ps\\'"		. postscript-mode)
	'("\\.uil\\'"		. uil-mode)
	'("\\.ht\\(ml?\\)?\\'"	. html-helper-mode)
	'("\\..*\\(cshrc\\|log\\(in\\|out\\)\\)\\'"	. csh-mode)
	'("\\.java\\'"		. java-mode)
	'("\\.X\\(defaults\\|ressource\\)\\'" . xrdb-mode)
	'("\\.vhdl?"		. vhdl-mode)
	)
       auto-mode-alist)
      
      ;; Shells en tout genre
      interpreter-mode-alist
      (append
       (list
	'("tcsh"		. csh-mode)
	'("csh"			. csh-mode)
	)
       interpreter-mode-alist)

      ;; Gestion des URL
      browse-url-save-file	t
      )

(provide 'variables)
