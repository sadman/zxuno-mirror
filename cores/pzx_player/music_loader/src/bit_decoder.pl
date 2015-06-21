#! /usr/bin/perl -wT

binmode STDIN ;

$, = $\ = "\n" ;

while(<>) {
    my $bits = unpack( "B*", $_ ) ;
    my @bits = split( //, $bits ) ;
    print @bits ;
}
