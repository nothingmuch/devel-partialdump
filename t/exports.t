#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use Test::Warn;

{
	package Foo;
	use ok 'Devel::PartialDump' => qw(warn show carp dump);

	sub w { warn ["foo"] }
	sub c { carp ["foo"] }
	sub d { dump ["foo"] }
	sub s { show ["foo"] }
}

can_ok( Foo => qw(warn show carp dump) );

warning_like { Foo::w } qr/foo/, 'warn';
warning_like { Foo::c } { carped => qr/foo/ }, 'carp';

warning_is { like( Foo::d, qr/foo/, "dump" ) } [], "dump doesn't warn";
warning_like { is_deeply( Foo::s, ["foo"], "show" ) } qr/foo/, "show warns";

