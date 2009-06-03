package Lingua::LO::Romanize;

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

Version 0.07

=cut

our $VERSION = '0.07';

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

    my $foo = Lingua::LO::Romanize->new(text => 'ພາສາລາວ');
    
    my $bar = $foo->romanize;           # $bar will hold the string 'phasalao'
    $bar = $foo->romanize(hyphen => 1); # $bar will hold the string 'pha-sa-lao'

=head1 DESCRIPTION

L<Lingua::LO::Romanize> romanizes lao text using the BGN/PCGN standard from 1966 (also know as the 'French style') with some modifications for post-revolutionary spellings (spellings introduced from 1975). One such modification is that Lao words has to be spelled out. For example, 'ສະຫວັນນະເຂດ' will be romanized correctly into 'savannakhét' while the older spelling 'ສວັນນະເຂດ' will not be romanized correctly due to lack of characters.

Furthermore, 'ຯ' will be romanized to '...', Lao numbers will be 'romanized' to Arabic numbers (0,1,2,3 etc.), and 'ໆ' will repeat the previous syllable. Se below for more romanization rules.

Note that all charcters are treated as UTF-8.

=head2 Romanization Rules

Consonants and vowels are generally romanized accourding to the following rules:

=head3 Consonants

=begin html

<table border="1">
<tr><th>Character</th><th>Syllable initial</th><th>Syllable Final</th><th>Notes</th></tr>
<tr><td>ກ</td><td>k</td><td>k</td><td></td></tr>
<tr><td>ຂ</td><td>kh</td><td></td><td></td></tr>
<tr><td>ຄ</td><td>kh</td><td></td><td></td></tr>
<tr><td>ງ</td><td>ng</td><td>ng</td><td></td></tr>
<tr><td>ຈ</td><td>ch</td><td></td><td></td></tr>
<tr><td>ສ</td><td>s</td><td></td><td></td></tr>
<tr><td>ຊ</td><td>x</td><td></td><td></td></tr>
<tr><td>ຍ,ຽ</td><td>gn</td><td>y</td><td>Could also be a vowel</td></tr>
<tr><td>ດ</td><td>d</td><td>t</td><td></td></tr>
<tr><td>ຕ</td><td>t</td><td></td><td></td></tr>
<tr><td>ຖ</td><td>th</td><td></td><td></td></tr>
<tr><td>ທ</td><td>th</td><td></td><td></td></tr>
<tr><td>ນ</td><td>n</td><td>n</td><td></td></tr>
<tr><td>ບ</td><td>b</td><td>p</td><td></td></tr>
<tr><td>ປ</td><td>p</td><td></td><td></td></tr>
<tr><td>ຜ</td><td>ph</td><td></td><td></td></tr>
<tr><td>ຝ</td><td>f</td><td></td><td></td></tr>
<tr><td>ພ</td><td>ph</td><td></td><td></td></tr>
<tr><td>ຟ</td><td>f</td><td></td><td></td></tr>
<tr><td>ມ</td><td>m</td><td>m</td><td></td></tr>
<tr><td>ຢ</td><td>y</td><td></td><td></td></tr>
<tr><td>ຣ,ຣ໌</td><td>r</td><td>r</td><td>ຣ໌ is rarely used and only in final position of words for example 'ເບີຣ໌'</td></tr>
<tr><td>ລ,◌ຼ</td><td>l</td><td></td><td></td></tr>
<tr><td>ວ</td><td>v,o</td><td>o,iou,oua</td><td>ວ can also be a vowel depending on it's position. The character ວ at the beginning of a syllable should be romanized v. As the second character of a combination,  ວ should be romanized o. The character ວ at the end of a syllable should be romanized in the following manner.  The syllables  ◌ິ ວ and ◌ີ ວ should be romanized iou. The syllable ◌ົ ວ (treated as a vowel) should be romanized oua. Otherwise, at the end of a syllable, ວ should be  romanized o.</td></tr>
<tr><td>ຫ</td><td>h</td><td></td><td>At the beginning of a syllable, the character ຫ unaccompanied by a vowel or tone mark and  occurring immediately before ຍ gn, ນ n, ມ m, ຣ r, ລ l, or ວ v should generally not be romanized. Note that the character combinations ຫນ, ຫມ and ຫລ are often written in abbreviated form:  ໜ n, ໝ m, and  ຫຼ l, respectively. ແຫນ is romanized to hèn and ແໜ romanized to nè.</td></tr>
<tr><td>ອ</td><td>-</td><td></td><td>ອ can also be a vowel. At the beginning of a word, ອ should not be romanized. At the beginning of a syllable within a word, ອ should be romanized by a hyphen.</td></tr>
<tr><td>ຮ</td><td>h</td><td></td><td></td></tr>
</table>

=end html

=head3 Vowels

=begin html

<table border="1">
<tr><th>Short final</th><th>Short medial</th><th>Long final</th><th>Long medial</th><th>Romanized</th></tr>
<tr><td>◌ະ</td><td>◌ັ</td><td>◌າ</td><td>◌າ</td><td>a</td></tr>
<tr><td>◌ິ</td><td>◌ິ</td><td>◌ີ</td><td>◌ີ</td><td>i</td></tr>
<tr><td>◌ຶ</td><td>◌ຶ</td><td>◌ື</td><td>◌ື</td><td>u</td></tr>
<tr><td>◌ຸ</td><td>◌ຸ</td><td>◌ູ</td><td>◌ູ</td><td>ou</td></tr>
<tr><td>ເ◌ະ</td><td>ເ◌ັ</td><td>ເ◌</td><td>ເ◌</td><td>é</td></tr>
<tr><td>ແ◌ະ</td><td>ແ◌ັ</td><td>ແ◌</td><td>ແ◌</td><td>è</td></tr>
<tr><td>ໂ◌ະ</td><td>◌ົ</td><td>ໂ◌</td><td>ໂ◌</td><td>ô</td></tr>
<tr><td>ເ◌າະ</td><td>◌ັອ</td><td>◌ໍ</td><td>◌ອ</td><td>o</td></tr>
<tr><td>◌ົວະ</td><td>◌ັວ</td><td>◌ົວ</td><td>◌ວ</td><td>oua</td></tr>
<tr><td>ເ◌ ັຽະ</td><td>◌ັຽ</td><td>ເ◌ັຽ</td><td>◌ຽ</td><td>ia</td></tr>
<tr><td>ເ◌ຶອະ</td><td>ເ◌ຶອ</td><td>ເ◌ືອ</td><td>ເ◌ືອ</td><td>ua</td></tr>
<tr><td>ເ◌ິະ</td><td>ເ◌ິ</td><td>ເ◌ີ</td><td>ເ◌ື</td><td>eu</td></tr>
<tr><td>ໄ◌</td><td></td><td>ໃ◌</td><td></td><td>ai</td></tr>
<tr><td>ເ◌ົາ</td><td></td><td></td><td></td><td>ao</td></tr>
<tr><td>◌ຳ</td><td></td><td></td><td></td><td>am</td></tr>

</table>

=end html

=head1 METHODS

=head2 new

Creates a new object, a Lao text string is required
    
    my $foo = Lingua::LO::Romanize->new(text => 'ພາສາລາວ');

=head2 text

If a string is passed as argument, this string will be used to romanized from.

    $foo->text('ເບຍ');

If no arguments as passed, an array reference of L<Lingua::LO::Romanize::Word> from the current text will be returned.

=head2 all_words

Will return an array reference of L<Lingua::LO::Romanize::Word> from the current text.

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
    return join '', @romanized_arr;
}

=head2 syllable_array

Returns the current text as an array of hash references. The key 'lao' represents the original syllable and 'romanized' the romanized syllable.

    foreach my $syllable ($foo->syllable_array) {
        my $lao_syllable = $syllable->{lao};
        my $romanized_syllable = $syllable->{romanized};
        ...
    }

=cut

sub syllable_array {
    my $self = shift;
    
    my @syllable_array;
    
    foreach my $word ($self->all_words) {
        foreach my $syllable ($word->all_syllables) {
            my $romanized_syll = $syllable->romanize;
            $romanized_syll =~ s/^-//;
            push @syllable_array, { lao => $syllable->syllable_str, romanized => $romanized_syll };
        }
    }
    return @syllable_array;
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

=head1 COPYRIGHT & LICENSE

Copyright 2009 Joakim Lagerqvist, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

no Moose;
__PACKAGE__->meta->make_immutable;

1; # End of Lingua::LO::Romanize
