package Lingua::LO::Romanize;

use warnings;
use strict;
use utf8;

use Moose;
use MooseX::AttributeHelpers;
use MooseX::Params::Validate;

use Lingua::LO::Romanize::Types;
use Lingua::LO::Romanize::Word;

=encoding utf-8

=head1 NAME

Lingua::LO::Romanize - Romanization of Lao language

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

has 'text' => (
    metaclass   => 'Collection::Array',
    is          => 'rw',
    isa         => 'Lingua::LO::Romanize::Types::WordArr',
    coerce      => 1,
    required    => 1,
    provides    => {
        elements    => 'all_words',
    },
);

=head1 SYNOPSIS

This module romanizes Lao text using the BGN/PCGN standard from 1966 (with some modifications, see below).

    use Lingua::LO::Romanize;

    my $foo = Lingua::LO::Romanize->new('ພາສາລາວ');
    
    my $bar = $foo->romanize;           # $bar will hold the string 'phasalao'
    $bar = $foo->romanize(hyphen => 1); # $bar will hold the string 'pha-sa-lao'

=head1 DESCRIPTION

L<Lingua::LO::Romanize> romanizes lao text using the BGN/PCGN standard from 1966 (also know as the 'French style') with some modifications for post-revolutionary spellings (spellings introduced from 1975). One such modification is that Lao words has to be spelled out. For example, 'ສະຫວັນນະເຂດ' will be romanized correctly into 'savannakhét' while the older spelling 'ສວັນນະເຂດ' will not be romanized correctly due to lack of characters.

Furthermore, 'ຯ' will be romanized to '...', Lao numbers will be 'romanized' to Arabic numbers (0,1,2,3 etc.), and 'ໆ' will repeat the previous syllable.

=head1 FUNCTIONS

=head2 new

Creates a new object, a Lao text string is required
    
    my $foo = Lingua::LO::Romanize->new('ພາສາລາວ');

=head2 text

If a string is passed as argument, this string will be used to romanized from.

    $foo->text('ເບຍ');

If no arguments as passed, an array reference of L<Lingua::LO::Romanize::Words> from the current text will be returned.

=head2 all_words

Will return an array reference of L<Lingua::LO::Romanize::Words> from the current text.

=head2 romanize

Returns the current text as a romanized string. If hyphen is true, the syllables will be hyphenated.

    my $string = $foo->romanize;
    
    my $string_with_hyphen = $foo->romanize(hyphen => 1);

=cut

sub romanize {
    my $self = shift;
    my ( $hyphen ) = validated_list( \@_,
              hyphen   => { isa => 'Bool', optional => 1 });
    
    my @romanized_arr;
    
    foreach my $word ($self->all_words) {
        $word->hyphen(1) if $hyphen;
        push @romanized_arr, $word->romanize;
    }
    return join ' ', @romanized_arr;
}

=head1 AUTHOR

Joakim Lagerqvist, C<< <jokke at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lingua-lo-romanize at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lingua-LO-Romanize>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::LO::Romanize


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-LO-Romanize>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lingua-LO-Romanize>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-LO-Romanize>

=item * Search CPAN

L<http://search.cpan.org/dist/Lingua-LO-Romanize/>

=back


=head1 UTF-8 FLAG

This treats utf8 flag transparently.


=head1 COPYRIGHT & LICENSE

Copyright 2009 Joakim Lagerqvist, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

no Moose;
__PACKAGE__->meta->make_immutable;

1; # End of Lingua::LO::Romanize
