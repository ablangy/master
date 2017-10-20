#
# Author          : @USER-NAME@
# Created On      : @DATE-STAMP@
# Last Modified By: 
# Last Modified On: 
# Update Count    : 0
#

package @PACKAGE@;
require 5.004;

use strict;
use vars qw( $VERSION @ISA );

use Carp;

$VERSION = do { my @r = (q$Revision:$ =~ /\d+/g);
		sprintf "%d."."%02d" x $#r, @r };

@ISA = qw();


=head1 NAME

@PACKAGE@ - 


=head1 DESCRIPTION


=head1 HÉRITAGE

        UNIVERSAL
	@PACKAGE@


=head1 DÉPENDANCES


=head1 CONSTRUCTEUR

=over 4

=item @PACKAGE@->new()

=cut #'
sub new
{
}


########################################################################
#
# Méthodes
#
########################################################################

=back

=head1 MÉTHODES

=over 4

=item $obj->xxx()

=cut #'
sub xxx
{
}


########################################################################

=item $obj->yyy()

=cut #'
sub yyy
{
}


########################################################################
#
# Méthodes privées
#
########################################################################

=back

=head1 MÉTHODES PRIVÉES

=over 4

=item $obj->_zzz()

=cut #'
sub _zzz
{
}


1;
__END__

########################################################################

=back


=head1 ATTRIBUTS

=over 4

=item $obj->{aaa}

=item $obj->{bbb}

=back


=head1 HISTORIQUE

 $Log$


=head1 AUTEUR

@USER-NAME@.

Créé le @DATE-STAMP@.

=cut
