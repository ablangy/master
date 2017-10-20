\input texinfo                @c -*- Texinfo -*-
@c %**start of header 
@setfilename @INFO-FILE-NAME@
@settitle XXX
@setchapternewpage odd
@c %**end of header

@ignore
 Author          : @USER-NAME@
 Created On      : @DATE-STAMP@
 Last Modified By: 
 Last Modified On: 
 Update Count    : 0                         
 Status          : Unknown, Use with caution!
@end ignore


@c Index des variables et des fonctions reunies
@syncodeindex vr fn
@c Index des concepts et des programmes reunis
@syncodeindex pg cp


@c %**Part 2: Summary Description and Copyright
@ifinfo
Copyright
@end ifinfo


@c %**Part 3: Titlepage and Copyright
@titlepage
@title XXX
@subtitle XXX
@author @USER-NAME@
@page
@vskip 0pt plus 1filll
Micro doc...
@sp 2
Copyright
@end titlepage


@c %**Part 4: 'Top' Node and Master Menu
@ifinfo
@node Top, FirstMenu, (dir), (dir)
@top C'est le top niveau....

Cette documentation contient les chapitres suivants:
@end ifinfo

@menu
* FirstMenu::                   Premier chapitre

@end menu


@c %**Part 5: The Body of the Document
@node FirstMenu, Next, Previous, Top
@c    node-name,   next,  previous, up
@chapter C'est le premier chapitre...



....



@node Index Concepts, Next, Prev, Top
@unnumbered Index des Concepts

@printindex cp

@node Index Noms, , Prev, Top
@unnumbered Index des Fonctions et des Variables

@printindex fn

@summarycontents
@contents
@bye


