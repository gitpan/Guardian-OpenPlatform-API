use Module::Build;

my $build = Module::Build->new(
			       module_name => 'Guardian::OpenPlatform::API',
                               dist_version => '0.03',
			       license     => 'perl',
			       requires    => {
                                 'perl'                => '5.008001',
                                 'LWP::UserAgent'      => '2.023',
                                 'Moose'               => '0',
                               },
			       build_requires => {
                                 'Test::More'          => '0.47',
                               },
			       create_makefile_pl => 'traditional',
);

$build->create_build_script;
