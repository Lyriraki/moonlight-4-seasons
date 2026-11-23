#!/usr/bin/perl
# Perl sample: variable, regex, hash, subroutine, package
use strict;
use warnings;
use List::Util qw(sum max);

use constant MAX_ITEMS => 100;

my $name   = "Alex";
my $ratio  = 3.14;
my @items  = (1, 2, 3, 0xFF);
my %config = (
    host  => '127.0.0.1',
    port  => 8080,
    debug => 0,
);

package Animal;

sub new {
    my ($class, %args) = @_;
    my $self = {
        species => $args{species} || 'unknown',
        sound   => $args{sound}   // '...',
    };
    return bless $self, $class;
}

sub speak {
    my $self = shift;
    return sprintf("%s makes a %s sound", $self->{species}, $self->{sound});
}

package main;

sub total {
    my (@numbers) = @_;
    return sum(@numbers) // 0;
}

my $dog = Animal->new(species => 'Dog', sound => 'woof');
print $dog->speak(), "\n";
print "Total: @{[ total(@items) ]}\n";

my $text = "Email: alex@example.com, sara@example.org";
while ($text =~ /([\w.]+)@([\w.]+)/g) {
    print "User: $1, host: $2\n";
}
(my $clean = $text) =~ s/\s+/ /g;

foreach my $key (sort keys %config) {
    printf "%-6s = %s\n", $key, $config{$key};
}

open(my $fh, '<', 'data.txt') or die "Cannot open file: $!";
while (my $line = <$fh>) {
    chomp $line;
    next if $line =~ /^#/;
    print "$line\n" unless $line eq '';
}
close($fh);
