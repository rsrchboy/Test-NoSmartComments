#!/usr/bin/env perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Test::NoSmartComments' );
}

diag("Testing Test::NoSmartComments $Test::NoSmartComments::VERSION, Perl $], $^X");
