#!/usr/bin/perl

use strict;
use Test::More;
use_ok('Parser');

for my $expr (
	"99",
	"-99",
	"1-(99)",
	"1500/-10",
	"2+3*-4/(3+8)-18",
	"2+(-2)",
	"22/3/4+((12+33)/4-1)*10-4/2",
	"8+4+(19-22+(-2))+99",
	"335-(-2)+(+2)",
	"100/2/2/2/2",
	"100/2/2/2-1/2",
	"100/2/2/(2-1)/2",
	"0+0-0",
	"(((1)))+22",
	"98-8*2/3+(22-((5)))*3"
){
	my $res = Parser::parse($expr);
	ok($res, "expression: $expr");
	isa_ok($res, 'Processor');
	is($res->calculate(), eval($expr));
}

done_testing;
