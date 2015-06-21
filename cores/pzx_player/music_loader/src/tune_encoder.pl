#! /usr/bin/perl -wT

#  1 3   6 8 10
#  C D   F G A
# C D E F G A H C
# 0 2 4 5 7 9 11

my @tune = (

38,8,41,8,45,48,43,24,41,24,40,16,38,8,41,8,45,40,48,8,47,24,43,16,47,8,45,16,
38,8,41,8,45,32,38,8,45,8,43,24,41,24,40,16,38,8,41,8,48,48,50,24,48,24,47,16,
48,8,55,8,60,48,58,24,57,24,55,16,48,8,55,8,60,32,55,8,60,8,58,8,57,8,55,8,53,8,55,32,
48,8,55,8,60,48,58,24,57,24,55,8,53,8,55,24,50,8,55,8,50,8,55,8,59,8,55,64,

) ;

my $transpose = -30 ;

my @t = @tune ;

my $d1 = 1710 ;

my @scale = ( map { 1 / 2 ** ( $_ / 12.0 ) } 0 .. 36 ) ;

my $t = 0 ;

my( $n, $d ) ;

print <<EOT ;
PULSES
PULSE 2168 3224
PULSE 667
PULSE 735

EOT

while(<>) {

    unless( defined $d ) {
        $n = shift @t ;
        $d = shift @t ;
        if ( @t == 0 ) {
            @t = @tune ;
        }
        
        $n += $transpose ;

        $n = int( $d1 * $scale[ $n ] ) ;

        $d *= 3500000 / 50 ;
        
        print "PACK 0 4\n" ;
    }

    next if /^#/ ;

    my $b = $_ + 0 ;
    
    if ( $b ) {
        print "PULSE ", 3 * $n, " 2\n" ;
        print "PULSE ", 2 * $n, "\n" ;
        print "PULSE ", 4 * $n, "\n" ;
    }
    else {
        print "PULSE ", 3 * $n, " 2\n" ;
        print "PULSE ", 4 * $n, "\n" ;
        print "PULSE ", 2 * $n, "\n" ;
    }
    
    $t += 12 * $n ;
    
    if ( $t >= $d ) {
        $t -= $d ;
        $d = undef ;
    }
}

print <<EOT ;

PULSE 945
EOT

