package Processor;

use strict;

sub new {
	my $class = shift;
	
	my $self = {
		operands   => [],
		operations => []
	};
	
	bless $self, $class;
}

sub add_operand {
	my ($self, $op) = @_;
	push @{$self->{operands}}, $op;
}

sub add_operation {
	my ($self, $op) = @_;
	push @{$self->{operations}}, $op;
}

sub validate {
	my $self = shift;
	return @{$self->{operands}} - @{$self->{operations}} == 1;
}

sub calculate {
	my $self = shift;
}

1;
