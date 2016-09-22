use strict;
use warnings;

use IO::File;

my $f = new IO::File 'bench.bin', '>' or die "Cannot open";
my $total = 1024 * 1024 * 1120;

my $buf = 'Q' x (1024 * 1024 * 8);
my $written = 0;

while ($written < $total)
{
	$written +=	$f->syswrite($buf) || die "Cannot write"; 
}

print "$written\n";
