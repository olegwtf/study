#!/usr/bin/perl

use strict;
use Test::More;
use_ok('Parser');

my $res = eval{ Parser::parse("2+3*-4/(3+8-18") };
ok(!$res);

done_testing;
