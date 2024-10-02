# -*- mode: perl; -*-

use strict;
use warnings;

use Test::More tests => 4112;
use Scalar::Util qw< refaddr >;

use Math::BigInt;
use Math::BigFloat;

# int(log(x) / log(10)

sub ilog10 {
    my $x = shift;
    my $y = int(log($x) / log(10));

    my $trial = 10 ** $y;
    return $y if $trial == $x;

    while ($trial < $x) {
        $y++;
        $trial = 10 ** $y;
    }

    while ($trial > $x) {
        $y--;
        $trial = 10 ** $y;
    }

    return $y;
}

my @cases =
  (
   [ "NaN", "NaN" ],
   [ "-1",  "NaN" ],
   [ "0",  "-inf" ],
  );

for (my $x = 1 ; $x <= 1025 ; $x++) {
    my $y = ilog10($x);
    push @cases, [ $x, $y ];
}

note("Testing Math::BigInt -> bilog10() without downgrading and upgrading");

note("\nbilog10() as a class method");

for my $case (@cases) {

    my ($test, $y, @y);
    my ($in0, $out0) = @$case;

    # Scalar context.

    $test = qq|\$y = Math::BigInt -> bilog10("$in0");|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 2;

        is(ref($y), 'Math::BigInt', '$y is a Math::BigInt');
        is($y, $out0, 'value of $y');
    };

    # List context.

    $test = qq|\@y = Math::BigInt -> bilog10("$in0");|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 3;

        is(scalar(@y), 1, 'number of output arguments');
        is(ref($y[0]), 'Math::BigInt', '$y[0] is a Math::BigInt');
        is($y[0], $out0, 'value of $y[0]');
    };
}

note("\nbilog10() as an instance method");

for my $case (@cases) {

    my ($test, $x, $y, @y);
    my ($in0, $out0) = @$case;

    # Scalar context.

    $test = qq|\$x = Math::BigInt -> new("$in0"); |
          . qq|\$y = \$x -> bilog10();|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 2;

        is(ref($y), 'Math::BigInt', '$y is a Math::BigInt');
        is($y, $out0, 'value of $y');
    };

    # List context.

    $test = qq|\@y = Math::BigInt -> bilog10("$in0");|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 3;

        is(scalar(@y), 1, 'number of output arguments');
        is(ref($y[0]), 'Math::BigInt', '$y[0] is a Math::BigInt');
        is($y[0], $out0, 'value of $y[0]');
    };
}

__END__

# The following tests require that the methods is implemented in
# Math::BigFloat. Fixme!

note("Testing Math::BigInt -> bilog10() with downgrading and upgrading");

Math::BigInt -> upgrade("Math::BigFloat");
Math::BigFloat -> downgrade("Math::BigInt");

note("\nbilog10() as a class method");

for my $case (@cases) {

    my ($test, $y, @y);
    my ($in0, $out0) = @$case;

    # Scalar context.

    $test = qq|\$y = Math::BigInt -> bilog10("$in0");|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 2;

        is(ref($y), 'Math::BigInt', '$y is a Math::BigInt');
        is($y, $out0, 'value of $y');
    };

    # List context.

    $test = qq|\@y = Math::BigInt -> bilog10("$in0");|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 3;

        is(scalar(@y), 1, 'number of output arguments');
        is(ref($y[0]), 'Math::BigInt', '$y[0] is a Math::BigInt');
        is($y[0], $out0, 'value of $y[0]');
    };
}

note("\nbilog10() as an instance method");

for my $case (@cases) {

    my ($test, $x, $y, @y);
    my ($in0, $out0) = @$case;

    # Scalar context.

    $test = qq|\$x = Math::BigInt -> new("$in0"); |
          . qq|\$y = \$x -> bilog10();|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 2;

        is(ref($y), 'Math::BigInt', '$y is a Math::BigInt');
        is($y, $out0, 'value of $y');
    };

    # List context.

    $test = qq|\@y = Math::BigInt -> bilog10("$in0");|;
    note "\n", $test, "\n\n";
    eval $test;
    die $@ if $@;

    subtest $test => sub {
        plan tests => 3;

        is(scalar(@y), 1, 'number of output arguments');
        is(ref($y[0]), 'Math::BigInt', '$y[0] is a Math::BigInt');
        is($y[0], $out0, 'value of $y[0]');
    };
}
