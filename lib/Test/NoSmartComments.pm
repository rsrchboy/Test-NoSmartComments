# See dist.ini or LICENSE for legal info
package Test::NoSmartComments;

# ABSTRACT: The great new Test::NoSmartComments!

use Moose;
use namespace::autoclean;
use common::sense;


__PACKAGE__->meta->make_immutable;
