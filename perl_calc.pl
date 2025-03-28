#!/usr/bin/perl
use strict;
use warnings;

my %vars;

print "> ";
while (my $line = <STDIN>) {
    chomp $line;
    $line =~ s/^\s+|\s+$//g;
    last if $line =~ /^\s*(exit|quit)\s*$/i;

    if ($line =~ /^(\w+)\s*=\s*(.+)$/) {
        my ($var, $expr) = ($1, $2);
        my $eval_expr = substitute_vars($expr);
        my $result = safe_eval($eval_expr);
        if (defined $result) {
            $vars{$var} = $result;
            print "$result\n";
        }
    } else {
        my $eval_expr = substitute_vars($line);
        my $result = safe_eval($eval_expr);
        print defined $result ? "$result\n" : "";
    }
    print "> ";
}

sub substitute_vars {
    my ($expr) = @_;
    $expr =~ s/(\b\w+\b)/exists $vars{$1} ? $vars{$1} : $1/eg;
    return $expr;
}

sub safe_eval {
    my ($expr) = @_;
    my $result = eval "$expr";
    if ($@) {
        print "Error: Invalid expression\n";
        return undef;
    } elsif ($expr =~ /\/0(?!\d)/) {
        print "Error: Division by zero\n";
        return undef;
    } elsif ($expr =~ /[a-zA-Z]/ && $expr =~ /\b(\w+)\b/ && !exists $vars{$1}) {
        print "Error: Undefined variable '$1'\n";
        return undef;
    }
    return $result;
}

