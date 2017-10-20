;;
;; group.el -- Expres pour les groupes...
;; 
;; Author          : Prout
;; Created On      : Tue Nov  1 01:40:50 1994
;; Last Modified By: root
;; Last Modified On: Sun Nov  6 20:58:33 1994
;; Update Count    : 2
;; Status          : Ca roule...
;;

(provide 'group)

(defvar user-group-all-var "BODY"
  "*Variable d'environnement contenant les noms des personnes du groupe
separes par des espaces, exemple: \"BODY\" si on a
setenv BODY \"Jano Lionnel Max Xiiik\"
Si la variable n'existe pas, ce n'est pas grave du tout...")

(defvar user-group-no-var "RXT_VAR"
  "*Variable d'environnement contenant comme premier caractere l'index de
l'utilisateur courant dans la variable user-group-all-var en option base 1,
exemple \"RXT_VAR\" si on a setenv RXT_VAR \"3 ...\" pour \"Max\" dans \"BODY\"
setenv BODY \"Jano Lionnel Max Xiiik\"
Si la variable n'existe pas, ce n'est pas grave du tout...")

(defun user-group-member-name ()
  "Extrait le nom de l'utilisateur courant dans le groupe.
Renvoie \"\" si quelque chose n'a pas marche...
On se sert des variables user-group-all-var et user-group-no-var"
  (if (and (stringp user-group-all-var) (stringp user-group-no-var))
      (let ((body (getenv user-group-all-var))
	    (no (getenv user-group-no-var))
	    (cont t)
	    boucle
	    (reg "")
	    (reg-init " \\([^ ]+\\)"))
	(if (or (null body)
		(null no)
		(not (numberp (setq no (car (read-from-string no))))))
	    ""
	  ;; no contient l'index du mec dans body
	  (setq boucle no)
	  (while (/= 0 boucle)
	    (setq reg (concat reg reg-init)
		  boucle (1- boucle))
	    )
	  (setq reg (substring reg 1))		;; La regexp est prete

	  (if (null (string-match reg body))
	      ""
	    (substring body (match-beginning no) (match-end no))
	    )
	  )
	)
    "")
  )

(defun user-group-full-name ()
  "Renvoie une chaine du type:
\(user-group-member-name\) \" from \" \(user-full-name\)
si tout s'est bien passe, sinon renvoie \(user-full-name\)"
  (let ((mec (user-group-member-name)))
    (if (string= "" mec)
	(user-full-name)
      (concat mec " from " (user-full-name)))
    )
  )
