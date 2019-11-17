#!/usr/bin/perl
sub caesar {
	my ($n,$w) = @_;
	return join('',map(chr($_<65||$_>91?$_:65+($_-65+$n)%26),map(ord,split(//,uc $w))));
	# ^ lmao
}

my @n = 0..25;
@n = ($1) if shift(@ARGV)=~/(\d+)/;
my @lines = (<>);
foreach my $i (@n) {
	print "$i:\n";
	print "\t",caesar($i,$_) for @lines;
}
