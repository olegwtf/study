package Parser;

use strict;
use Carp;
use Processor;

sub parse {
	my $str = shift;
	_parse(\$str);
}

sub _parse {
	my ($str_ref, $sub_expr) = @_;
	
	my $proc = Processor->new();
	
	while (pos($$str_ref) < length $$str_ref) {
		if ($$str_ref =~ /\G([+-]?\d+)/gc) {
			$proc->add_operand($1);
		}
		elsif ($$str_ref =~ /\G\(/gc) {
			$proc->add_operand(_parse($str_ref, 1));
			$$str_ref =~ /\G\)/gc
				or croak 'expected closing parenthesis at offset ' . pos($$str_ref);
		}
		else {
			croak 'bad expression at offset ' . pos($$str_ref);
		}
		
		if (pos($$str_ref) < length $$str_ref) {
			if ($$str_ref =~ /\G(?=\))/gc) {
				if ($sub_expr) {
					return $proc;
				}
				else {
					croak 'closing parenthesis without opening one at offset ' . pos($$str_ref);
				}
			}
			
			if ($$str_ref =~ /\G([+*\/-])/gc) {
				$proc->add_operation($1);
			}
			else {
				croak 'expected operation at offset ' . pos($$str_ref);
			}
		}
	}
	
	$proc->validate()
		or croak 'expression ends with operation';
	
	return $proc;
}

1;
