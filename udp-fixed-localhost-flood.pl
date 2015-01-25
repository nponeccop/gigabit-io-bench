use IO::Socket::INET;

my $sock = IO::Socket::INET->new
	( PeerPort  => 9999,
	, PeerAddr  => '127.0.0.1'
	, Proto     => udp,
	, LocalAddr => 'localhost'
	);

my $s = 'Q' x 64;
my $toSend = 10 * 1000 * 1000;
print "$toSend\n";
for (my $i = $toSend; $i > 0; $i--)
{
	$sock->write($s);		
};

