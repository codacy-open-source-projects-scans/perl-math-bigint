# -*- mode: perl; -*-

use strict;
use warnings;

use Test::More tests => 2 * 222;

use Math::BigInt;

while (<DATA>) {
    s/#.*$//;                   # remove comments
    s/\s+$//;                   # remove trailing whitespace
    next unless length;         # skip empty lines

    my ($x_str, $expected) = split /:/;
    my ($x, $str);

    for my $accu ("undef", "20") {
        my $test = qq|Math::BigInt -> accuracy($accu);|
                 . qq| \$x = Math::BigInt -> new("$x_str");|
                 . qq| \$str = \$x -> bdstr();|;

        note "\n$test\n\n";
        eval $test;
        die $@ if $@;           # should never happen

        is($str, $expected, qq|output is "$expected"|);
        if ($x_str eq 'NaN') {
            ok($x -> is_nan(), "input object is unmodified");
        } else {
            cmp_ok($x, "==", $x_str, "input object is unmodified");
        }
    }
}

__DATA__

NaN:NaN

inf:inf
-inf:-inf

0:0
-0:0

# positive numbers

1:1
10:10
100:100
1000:1000
10000:10000
100000:100000
1000000:1000000
10000000:10000000
100000000:100000000
1000000000:1000000000
10000000000:10000000000
100000000000:100000000000
1000000000000:1000000000000

12:12
120:120
1200:1200
12000:12000
120000:120000
1200000:1200000
12000000:12000000
120000000:120000000
1200000000:1200000000
12000000000:12000000000
120000000000:120000000000
1200000000000:1200000000000

123:123
1230:1230
12300:12300
123000:123000
1230000:1230000
12300000:12300000
123000000:123000000
1230000000:1230000000
12300000000:12300000000
123000000000:123000000000
1230000000000:1230000000000

1234:1234
12340:12340
123400:123400
1234000:1234000
12340000:12340000
123400000:123400000
1234000000:1234000000
12340000000:12340000000
123400000000:123400000000
1234000000000:1234000000000

3:3
31:31
314:314
3141:3141
31415:31415
314159:314159
3141592:3141592

# negative numbers

-1:-1
-10:-10
-100:-100
-1000:-1000
-10000:-10000
-100000:-100000
-1000000:-1000000
-10000000:-10000000
-100000000:-100000000
-1000000000:-1000000000
-10000000000:-10000000000
-100000000000:-100000000000
-1000000000000:-1000000000000

-12:-12
-120:-120
-1200:-1200
-12000:-12000
-120000:-120000
-1200000:-1200000
-12000000:-12000000
-120000000:-120000000
-1200000000:-1200000000
-12000000000:-12000000000
-120000000000:-120000000000
-1200000000000:-1200000000000

-123:-123
-1230:-1230
-12300:-12300
-123000:-123000
-1230000:-1230000
-12300000:-12300000
-123000000:-123000000
-1230000000:-1230000000
-12300000000:-12300000000
-123000000000:-123000000000
-1230000000000:-1230000000000

-1234:-1234
-12340:-12340
-123400:-123400
-1234000:-1234000
-12340000:-12340000
-123400000:-123400000
-1234000000:-1234000000
-12340000000:-12340000000
-123400000000:-123400000000
-1234000000000:-1234000000000

-3:-3
-31:-31
-314:-314
-3141:-3141
-31415:-31415
-314159:-314159
-3141592:-3141592
