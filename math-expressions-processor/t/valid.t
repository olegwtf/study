#!/usr/bin/perl

use strict;
use Test::More;
use_ok('Parser');

my $res = Parser::parse("2+3*-4/(3+8)-18");
ok($res);
isa_ok($res, 'Processor');

done_testing;
