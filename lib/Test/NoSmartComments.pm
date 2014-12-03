package Test::NoSmartComments;

# ABSTRACT: Make sure no Smart::Comments escape into the wild

use strict;
use warnings;

use base 'Test::Builder::Module';

my $CLASS = __PACKAGE__;

use Module::ScanDeps;
use ExtUtils::Manifest qw( maniread );

our @EXPORT = qw{ no_smart_comments_in no_smart_comments_in_all };


sub no_smart_comments_in_all {
    my $tb = $CLASS->builder;
    my $manifest = maniread();
    my @files = sort grep { m!^lib/.*\.pm$! } keys %$manifest;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    no_smart_comments_in($_) for @files;

    return;
}

sub no_smart_comments_in {
    my $file = shift @_;
    my $tb = $CLASS->builder;

    $tb->diag("No such file: $file") unless -f $file;

    my $dep = scan_deps(files => [ $file ], recurse => 0);
    $tb->ok(!exists $dep->{'Smart/Comments.pm'}, "$file w/o Smart::Comments");
    return;
}

1;

__END__

=head1 SYNOPSIS

    use Test::More;
    eval "use Test::NoSmartComments";
    plan skip_all => 'Test::NoSmartComments required for checking comment IQ'
        if $@ ;

    no_smart_comments_in;
    done_testing;

=head1 DESCRIPTION

L<Smart::Comment>s are great.  However, letting smart comments escape into the
wilds of the CPAN is just dumb.

This package provides a simple way to test for smart comments _before_ they
get away!

=head1 FUNCTIONS

=head2 no_smart_comments_in($file)

Called with a file name, this function scans it for the use of
L<the Smart::Comments module|Smart::Comments>.

=head2 no_smart_comments_in_all()

no_smart_comments_in_all() scans the MANIFEST for all matching qr!^lib/.*.pm$!
and issues a pass or fail for each.

=head1 SEE ALSO

L<Smart::Comments>, L<Dist::Zilla::Plugin::NoSmartCommentsTests>

=cut

