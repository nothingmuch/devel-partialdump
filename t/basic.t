#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Devel::PartialDump';

my $d = Devel::PartialDump->new;

is( $d->dump("foo"), '"foo"', "simple value" );

is( $d->dump("foo" => "bar"), 'foo: "bar"', "named params" );

is( $d->dump( foo => "bar", gorch => [ 1, "bah" ] ), 'foo: "bar", gorch: [ 1, "bah" ]', "recursion" );

like( $d->dump( [ { foo => ["bar"] } ] ), qr/\[ \{ foo: ARRAY\(0x[a-z0-9]+\) \} \]/i, "max depth" );

is( $d->dump([ 1 .. 10 ]), '[ 1, 2, 3, 4, 5, 6, ... ]', "max elements" );

is( $d->dump("foo\nbar"), '"foo\nbar"', "newline" );

is( $d->dump("foo" . chr(1)), '"foo\x{1}"', "non printable" );

