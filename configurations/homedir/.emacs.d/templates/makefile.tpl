#
# @FILE-NAME@ -- 
# 
# Author          : @USER-NAME@
# Created On      : @DATE-STAMP@
# Last Modified By: 
# Last Modified On: 
# Update Count    : 0
# Status          : Very good Makefile !!!
#

SHELL	= /bin/sh

# EXECUTABLE  - Nom de l'executable final
NAME		= 

# SOURCES - nom des fichiers sources
SRC		= 

CC		= gcc
CFLAGS		= -g2
LDFLAGS		= -g

# INCLUDE - nom des includes
I_STANDARD      =
I_MY            =

# LIBRAIRIE - nom des librairies a linker
L_STANDARD	= 
L_MY		= 

# ARCHIVE - nom des fichiers objets a archiver pour faire
#           eventuellement une librairie. A ne remplir que
#           pour produire des fichiers d'extension .a

A_PATH		= .
A_NAME		= 
A_OBJ		= 

# ------------------------------------------------------------------------------

INCL	= $(I_MY) $(I_STANDARD)  
I_PATH	= -I.

OBJS	= $(SRC:.c=.o)

LIBS	= $(L_MY) $(L_STANDARD)  
L_PATH 	= -L. 


# VPATH est utilisee uniquement avec gmake. Elle permet de preciser
# les chemins ou l'on peut trouver les fichiers (les repertoires sont
# separes par ':' ( ex: VPATH = src:src/Paul:src/Pierre )

VPATH	= 

GMAKE		= gmake

# Autres programmes utilises

COMPRESS	= gzip -f
UNCOMPRESS	= gunzip -f

RM		= rm -f
STRIP		= echo strip

RCS		= rcs
CHECK_IN	= ci
CHECK_OUT	= co
CHECK_OUT_OPTI	= -l

TAR		= tar cvf
DETAR		= tar xvf

ARCHIVER	= ar
AR_CONTENT	= ranlib
APPEND_AR	= cq
REPLACE_AR	= ru
EXTRACT_AR	= x
PRINT_AR	= t
DEL_AR		= d

ECHO		= echo

MAKE_DEPEND	= makedepend



# REGLES

all	: $(NAME)

$(NAME) : $(OBJS)
	$(CC) $(LDFLAGS) -o $(NAME) $(OBJS) $(L_PATH) $(LIBS)

update	: clean all

clean	: erasename
	-$(RM) *~ $(OBJS)

erasename:
	-$(RM) $(NAME)

tapear	: erase
	$(TAR) $(NAME).tar `ls -1 | egrep -v "RCS|.,v"`
	$(COMPRESS) $(NAME).tar
	$(RM) `ls -1 | egrep -v "$(NAME).tar|.,v"`

link: erasename all

ar	: $(A_OBJ)
	@echo $(HOSTTYPE) > last_hosttype.make
	@if [ `env | grep PATH_TO_PUT_LIB_IN | wc -c` != 0 ] ; then  \
	   $(ECHO) "PATH_TO_PUT_LIB_IN est utilise" ; \
	   if [ -r ${PATH_TO_PUT_LIB_IN}/${A_NAME} ] ; then \
	      $(ECHO) ${A_OBJ} "sont remplaces dans" ${PATH_TO_PUT_LIB_IN}/${A_NAME} ; \
	      $(ARCHIVER) $(REPLACE_AR) ${PATH_TO_PUT_LIB_IN}/${A_NAME} ${A_OBJ} ; \
	   else \
	      $(ECHO) ${A_OBJ} "sont ajoutes dans" ${PATH_TO_PUT_LIB_IN}/${A_NAME}; \
	      $(ARCHIVER) $(APPEND_AR) ${PATH_TO_PUT_LIB_IN}/${A_NAME} ${A_OBJ} ; \
	      $(AR_CONTENT) ${PATH_TO_PUT_LIB_IN}/${A_NAME} ${A_OBJ} ; \
	   fi \
	else \
	   if [ -r ${A_PATH}/${A_NAME} ] ; then \
	      $(ECHO) ${A_OBJ} "sont remplaces dans" ${A_PATH}/${A_NAME} ; \
	      $(ARCHIVER) $(REPLACE_AR) ${A_PATH}/${A_NAME} ${A_OBJ} ; \
	   else \
	      $(ECHO) ${A_OBJ} "sont ajoutes dans" ${A_PATH}/${A_NAME}; \
	      $(ARCHIVER) $(APPEND_AR) ${A_PATH}/${A_NAME} ${A_OBJ} ; \
	      $(AR_CONTENT) ${A_PATH}/${A_NAME} ${A_OBJ} ; \
	   fi \
	fi


depend:
	$(MAKE_DEPEND) $(I_PATH) $(SRC)

.SUFFIXES: .c.Z .c.gz .c.z   	\
           .h.Z .h.gz .h.z      \
           .y.Z .y.gz .y.z      \
           .l.Z .l.gz .l.z      \
           .x.Z .x.gz .x.z .c,v

.c.o:
	$(CC) $(CFLAGS) -c  $< $(I_PATH) 

.c.Z.c .h.Z.h .l.Z.l .y.Z.y .x.Z.x \
c.gz.c .h.gz.h .l.gz.l y.gz.y .x.gz.x \
.c.z.c .h.z.h .y.z.y .l.z.l .x.z.x:
	$(UNCOMPRESS) $<

.c,v.c:
	@if [ -f $< ] && [ ! -f $(<:.c,v=.c) ] ; then \
	  echo '> *** RCS' $(<:.c,v=.c) 'est extrait ***' ;\
	  $(CHECK_OUT) $(CHECK_OUT_OPTI) $< ; \
	fi

# DEPENDANCES
