# gcalc.pl - Google calculator example
#
# © Copyright, 2004-2005 By John Bokma, http://johnbokma.com/
#
# This script is for educational purposes only.
#
# $Id: gcalc.pl 1088 2008-09-30 19:11:55Z john $ 

use strict;
use warnings;

use URI::Escape;
use LWP::UserAgent;


unless ( @ARGV ) {

    print "usage: gcalc.pl expression\n",
          "    example: gcalc.pl 75 kg in stones\n";
    exit( 1 ) ;
}

my $url = 'http://www.google.com/search?num=1&q=' .
    uri_escape( join ' ' => @ARGV );

my $ua = LWP::UserAgent->new( agent => 'Mozilla/5.0' );
my $response = $ua->get( $url );

$response->is_success or
    die "$url: ", $response->status_line;

my $content = $response->content;

my ( $result ) = $content =~ m|<td nowrap><font size=\+1><b>(.*?)</b></td>|;

if ( $result ) {

    $result =~ s/<sup>/^/g;
    $result =~ s/&times;/x/g;
    $result =~ s/<.+?>//g;

    print "$result\n";

} else {

    print "No result\n";
}
