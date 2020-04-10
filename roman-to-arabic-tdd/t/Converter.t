use strict;
use Test::More;

use_ok 'Converter';

# valid
is Converter::convert('I'), 1;
is Converter::convert('II'), 2;
is Converter::convert('III'), 3;
is Converter::convert('V'), 5;
is Converter::convert('VI'), 6;
is Converter::convert('VII'), 7;
is Converter::convert('VIII'), 8;
is Converter::convert('IV'), 4;
is Converter::convert('X'), 10;
is Converter::convert('IX'), 9;
is Converter::convert('XIV'), 14;
is Converter::convert('XIX'), 19;
is Converter::convert('XI'), 11;
is Converter::convert('XIII'), 13;
is Converter::convert('XVIII'), 18;
is Converter::convert('XX'), 20;
is Converter::convert('XXVIII'), 28;
is Converter::convert('XXIX'), 29;
is Converter::convert('XXXIX'), 39;
is Converter::convert('L'), 50;
is Converter::convert('LIII'), 53;
is Converter::convert('LVII'), 57;
is Converter::convert('XL'), 40;
is Converter::convert('XLIX'), 49;
is Converter::convert('LIX'), 59;
is Converter::convert('LXXIX'), 79;
is Converter::convert('C'), 100;
is Converter::convert('XC'), 90;
is Converter::convert('XCIX'), 99;
is Converter::convert('CC'), 200;
is Converter::convert('D'), 500;
is Converter::convert('CDXCIX'), 499;
is Converter::convert('CMXCIX'), 999;
is Converter::convert('MMCMXCIX'), 2999;
is Converter::convert('MMMCMXCIX'), 3999;
is Converter::convert('CXL'), 140;
is Converter::convert('CIX'), 109;

# invalid
ok !eval{ Converter::convert('3') };
ok !eval{ Converter::convert('K') };
ok !eval{ Converter::convert('x') };
ok !eval{ Converter::convert('V8I') };
ok !eval{ Converter::convert('MMMM') }; # могут повторяться не более трех раз подряд
ok !eval{ Converter::convert('XM') }; # вычитаемое не из ближайшего числового ряда
ok !eval{ Converter::convert('XD') }; # вычитаемое не из ближайшего числового ряда
ok !eval{ Converter::convert('IIX') }; # вычитаемое с повтором
ok !eval{ Converter::convert('VX') }; # вычитаемое не 1 и не степень 10
ok !eval{ Converter::convert('DD') }; # D не может повторяться, есть M
ok !eval{ Converter::convert('VV') }; # V не может повторяться, есть X
ok !eval{ Converter::convert('LL') }; # L не может повторяться, есть C
ok !eval{ Converter::convert('IXL') }; # вычитаемое не 1 и не степень 10 (IX=9)
ok !eval{ Converter::convert('VIX') };# вычитаемое не 1 и не степень 10 (VI=6)
ok !eval{ Converter::convert('CIXL') };# вычитаемое не 1 и не степень 10 (IX=9)


done_testing;

__END__
http://graecolatini.bsu.by/htm-different/num-converter-roman.htm
В настоящее время в римской системе счисления используются следующие знаки:

I = 1; V = 5; X = 10; L = 50; C = 100; D = 500; M = 1000.
Все целые числа от 1 до 3999 записываются с помощью приведенных выше цифр. При этом:

если большая цифра стоит перед меньшей, они складываются:
VI = 5 + 1 = 6; XV = 10 + 5 = 15; LX = 50 + 10 = 60; CL = 100 + 50 = 150;
если меньшая цифра стоит перед большей (в этом случае она не может повторяться), то меньшая вычитается из большей; вычитаться могут только цифры, обозначающие 1 или степени 10; уменьшаемым может быть только цифра, ближайшая в числовом ряду к вычитаемой:
IV = 5 - 1 = 4; IX = 10 - 1 = 9; XL = 50 - 10 = 40; XC = 100 - 10 = 90;
цифры V, L, D не могут повторяться; цифры I, X, C, M могут повторяться не более трех раз подряд:
VIII = 8; LXXX = 80; DCCC = 800; MMMD = 3500.
