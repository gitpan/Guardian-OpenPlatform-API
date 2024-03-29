use Module::Build;

my $build = Module::Build->new(
			       module_name => 'Guardian::OpenPlatform::API',
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
