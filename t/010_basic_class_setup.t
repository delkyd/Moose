#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 12;
use Test::Exception;

BEGIN {
    use_ok('Moose');           
}

{
    package Foo;
    use Moose;
}

can_ok('Foo', 'meta');
isa_ok(Foo->meta, 'Moose::Meta::Class');

ok(!Foo->meta->has_method('meta'), '... we get the &meta method from Moose::Object');
ok(Foo->isa('Moose::Object'), '... Foo is automagically a Moose::Object');

foreach my $function (qw(
						 extends
    	                 has 
	                     before after around
	                     blessed confess
	                     )) {
    ok(!Foo->meta->has_method($function), '... the meta does not treat "' . $function . '" as a method');
}

