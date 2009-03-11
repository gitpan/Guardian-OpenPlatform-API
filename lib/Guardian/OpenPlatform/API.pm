=head1 NAME

Guardian::OpenPlatform::API - Access the Guardian OpenPlatform API

=head1 SYNOPSIS

  my $api = Guardian::OpenPlatform::API->new({
              api_key => 'your api key here',
            });

  my $resp = $api->content({
               qry => 'environment',
             });

=head1 DESCRIPTION

Guardian::OpenPlatform::API is module which simplifies access to the
Guardian's OpenPlatform content API. See
L<http://www.guardian.co.uk/open-platform> for more details on the content
available.

You will need a Guardian developer key in order to use this module. You can
get a key from the OpenPlatform web site.

=cut

package Guardian::OpenPlatform::API;

use 5.006000;

use Moose;
use LWP;
use Carp;

our $VERSION = '0.01';

my $base_url = 'http://api.guardianapis.com/';

has 'ua' => (
    is => 'rw',
    isa => 'LWP::UserAgent',
    );

has 'api_key' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    );

has 'format' => (
    is => 'rw',
    isa => 'Str',
    default => 'json',
    );

sub BUILD {
    my $self = shift;

    $self->{ua} = LWP::UserAgent->new;
}

=head1 METHODS

=head2 new({ api_key => $key [, format => '(xml|json)'] })

Create a new Guardian::OpenPlatform::API object. Takes a reference to a
hash of arguments. This hash has one mandatory key and one optional key.

=over 4

=item api_key

This item is mandatory. The value should be your Guardian API access key.

=item format

This item is optional. It defines the default format for the data that you
get back from the Guardian. Valid values are 'json' or 'xml'. If this
argument is omitted then it 'json' is used.

=back

=head2 content({ qry => $query, [ filter => $filter, format => $fmt ] });

Request content from the Guardian. Takes a reference to a hash of arguments.
This hash has one mandatory key and two optional keys.

=over 4

=item qry

This item is mandatory. Defines the the text that you want to get data about.

=item filter

This item is optional. Defines filters to be applied to your query. If you
have a single query then the value can be a single scalar value. If you have
multiple queries, then the value can be a reference to an array of scalar
values.

=item format

This item is optional. Defines the data format that you want to get back.
This can be either 'json' or 'xml'. If no value is given then the default
format given to the C<new> method is used.

=back

This method returns an HTTP::Response object.

=cut

sub content {
    my $self = shift;

    my $args = shift;

    my $url = $base_url . "content/search?q=$args->{qry}";

    if ($args->{filter}) {
	unless (ref $args->{filter}) {
	    $url .= "&filter=$args->{filter}";
	}

	if (ref $args->{filter} eq 'ARRAY') {
	    foreach (@{$args->{filter}}) {
		$url .= "&filter=$_";
	    }
	}
    }

    my $fmt = $args->{format} || $self->format;
    $url .= "&format=$fmt";

    $url .= '&api_key=' . $self->api_key;

    my $resp = $self->{ua}->get($url);
}

=head1 TODO

This is really just a simple proof of concept. It will get better, I promise.

=head1 BUGS, REQUESTS, COMMENTS

BUGS, REQUESTS, COMMENTS

Support for this module is supplied using the CPAN RT system via the web or 
email:

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Guardian::OpenPlatform::API>

bug-www-shorten@rt.cpan.org

This makes it much easier for me to track things and thus means your problem
is less likely to be neglected.

=head1 SOURCE CODE

Source code for this module is available on GitHub at

=over 4

=item *

http://github.com/davorg/guardian-openplatform-api/

=back

Please feel free to clone, fork and otherwise play with it.

=head1 LICENCE AND COPYRIGHT

Copyright (c) Magnum Solutions Ltd., 2009. All rights reserved.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.000 or, at your option,
any later version of Perl 5 you may have available.

The full text of the licences can be found in perlartistic and perlgpl as
supplied with Perl 5.8.1 and later.

=head1 AUTHOR

Dave Cross, E<lt>dave@mag-sol.comE<gt>

=cut

1;
