use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Lingua::LO::Romanize',
    license             => 'perl',
    dist_author         => 'Joakim Lagerqvist <jokke@cpan.org>',
    dist_version_from   => 'lib/Lingua/LO/Romanize.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Lingua-LO-Romanize-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
