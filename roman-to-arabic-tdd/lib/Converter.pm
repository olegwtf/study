package Converter;

use v5.12;
use strict;
use warnings;

sub _a($) {
    state $values = {I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000};
    return $values->{$_[0]} || die 'Invalid character: ', $_[0];
}

sub convert {
    my $roman = shift;
    
    my @roman = split //, $roman;
    my $arab = 0;
    
    my %repeat_state = (V => 0, L => 0, D => 0);
    my %repeat_in_a_row = (char => '', cnt => 0);
    my $state_validator = sub {
        my $c = $_[0];
        die $c, " should not be repeated" if exists $repeat_state{$c} && $repeat_state{$c}++;
        
        if ($repeat_in_a_row{char} ne $c) {
            $repeat_in_a_row{char} = $c;
            $repeat_in_a_row{cnt} = 1;
        }
        else {
            die 'Too much repeats in a row for: ', $c if ++$repeat_in_a_row{cnt} == 4;
        }
    };
    
    my $to_substract;
    
    for (my $i=0; $i<@roman; $i++) {
        $state_validator->($roman[$i]);
        my $c = _a$roman[$i];
        
        if ($to_substract) {
            $c -= $to_substract;
            $to_substract = undef;
        }
        
        if ($i == @roman - 1 || $c >= _a$roman[$i+1]) {
            # большая (такая же) стоит перед меньшей или это последняя цифра
            $arab += $c;
            next;
        }
        
        # меньшая стоит перед большей
        
        die 'Subtrahend should be 1 or 10^x: ', $roman unless $c =~ s/0+$//r == 1;
        die 'Not nearest number used for substraction: ', $roman if $c*10 < _a$roman[$i+1];
        die 'Incorrect sequence: ', $roman if $arab && _a$roman[$i+1] > $arab; # VIX например
        
        $to_substract = _a($roman[$i]);
    }
    
    return $arab;
}

1;

__END__
http://graecolatini.bsu.by/htm-different/num-converter-roman.htm
В настоящее время в римской системе счисления используются следующие знаки:

I = 1; V = 5; X = 10; L = 50; C = 100; D = 500; M = 1000.
Все целые числа от 1 до 3999 записываются с помощью приведенных выше цифр. При этом:

если большая цифра стоит перед меньшей, они складываются:
VI = 5 + 1 = 6; XV = 10 + 5 = 15; LX = 50 + 10 = 60; CL = 100 + 50 = 150;

если меньшая цифра стоит перед большей, то меньшая вычитается из большей
    * вычитаемая не может повторяться
    * вычитаться могут только цифры, обозначающие 1 или степени 10;
    * уменьшаемым может быть только цифра, ближайшая в числовом ряду к вычитаемой
    * цифры V, L, D не могут повторяться
    * цифры I, X, C, M могут повторяться не более трех раз подряд
