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

my @ops = (
	{
		* => sub { $_[0]*$_[1] },
		/ => sub { $_[0]/$_[1] }
	},
	{
		+ => sub { $_[0]+$_[1] },
		- => sub { $_[0]-$_[1] }
	}
	
);

sub calculate {
	my $self = shift;
	my $result;
	
	for my $ops (@ops) {
		for (my $i=$#{$self->{operations}}; $i>=0; $i--) {
			if (exists $ops->{$self->{operations}[$i]}) {
				$result = $ops->{$self->{operations}[$i]}->(
					map {
						ref $_ ? $_->calculate() : $_
					}
					$self->{operands}[$i+1],
					$self->{operands}[$i];
				);
				
				$self->{operands}[$i] = $result;
				splice @{$self->{operands}}, $i+1, 1;
				splice @{$self->{operations}}, $i, 1;
			}
		}
	}
}

1;
