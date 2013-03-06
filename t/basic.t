use strict;
use warnings;

use FindBin;
use Test::More;
use HTTP::Request::Common;
use Plack::Test;
use Plack::Builder;

my $app = builder {
    enable 'DefaultDocument',
        '/default.txt' => "$FindBin::Bin/htdocs/default.txt",
        '/missing.txt' => "$FindBin::Bin/htdocs/missing.txt";
    sub { [ 404, [], [ '' ] ] };
};

test_psgi $app, sub {
    my $cb = shift;

    my $res;
    $res = $cb->(GET 'http://localhost/default.txt');
    is $res->code, 200;
    is $res->content, "default!!\n";
    is $res->headers->header('Content-Type'), 'text/plain';
    
    $res = $cb->(GET 'http://localhost/404.txt');
    is $res->code, 404;
    is $res->headers->header('Content-Type'), undef;

    $res = $cb->(GET 'http://localhost/missing.txt');
    is $res->code, 404;
    is $res->headers->header('Content-Type'), undef;
};

done_testing;
