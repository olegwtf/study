#!/usr/bin/perl

use strict;
use Test::More;
use_ok('Parser');

for my $expr (
	"",
	"1+2+3+",
	"2 + 3",
	"2+3*-4/(3+8-18",
	"99+++32",
	"1500/--10"
) {
	my $res = eval{ Parser::parse($expr) };
	ok(!$res, "expression: $expr");
}

done_testing;
