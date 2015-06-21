#! /usr/bin/perl -wT

my $l = 0 ;

sub encode($$)
{
    my ( $b, $n ) = @_ ;
    
    print "# $b\n" ;
    
    if ( $b ) {
        print "$l\n" ;
        $l ^= 1 ;
        print "$l\n" ;
    }
    elsif ( $n ) {
        print "$l\n" ;
        print "$l\n" ;
    }
    else {
        print "$l\n" ;
        print "$l\n" ;
        $l ^= 1 ;
    }
}

my $p ;

while(<>) {

    next if /^#/ ;

    my $b = $_ + 0 ;

    encode( $p, $b ) if defined $p ;
    
    $p = $b ;
}

encode( $p, 0 ) if defined $p ;
