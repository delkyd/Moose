#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

BEGIN {  
    use_ok('Moose');               
}

{
    package Foo::Role;
    use strict;
    use warnings;
    use Moose::Role;
    
    requires 'foo';
}

# classes which does not implement required method
{
    package Foo::Class;
    use strict;
    use warnings;
    use Moose;
    
    ::dies_ok { with('Foo::Role') } '... no foo method implemented by Foo::Class';
}

# class which does implement required method
{
    package Bar::Class;
    use strict;
    use warnings;
    use Moose;
    
    ::lives_ok { with('Foo::Role') } '... has a foo method implemented by Bar::Class';
    
    sub foo { 'Bar::Class::foo' }
}

# role which does implement required method
{
    package Bar::Role;
    use strict;
    use warnings;
    use Moose::Role;
    
    ::lives_ok { with('Foo::Role') } '... has a foo method implemented by Bar::Role';
    
    sub foo { 'Bar::Role::foo' }
}

# role which does not implement required method
{
    package Baz::Role;
    use strict;
    use warnings;
    use Moose;
    
    ::dies_ok { with('Foo::Role') } '... no foo method implemented by Baz::Role';
}

