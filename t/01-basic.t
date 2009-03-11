use Test::More;

BEGIN {

  if ($ENV{GUARDIAN_API_KEY}) {
    plan tests => 14;
  } else {
    plan skip_all => 'Please set environment variable GUARDIAN_API_KEY';
  }

  use_ok('Guardian::OpenPlatform::API');
}

ok(my $client = Guardian::OpenPlatform::API->new(
  api_key => $ENV{GUARDIAN_API_KEY},
), 'Got client');
isa_ok($client, 'Guardian::OpenPlatform::API');

is($client->format, 'json', 'Default format correct');
isa_ok($client->ua, 'LWP::UserAgent');
is($client->api_key, $ENV{GUARDIAN_API_KEY}, 'API key correct');

my $resp = $client->content({
  qry => 'environment',
});

ok($resp, 'Got a response');
isa_ok($resp, 'HTTP::Response');
ok($resp->is_success, 'Successful request');
is($resp->header('Content-type'), 'application/json; charset=UTF-8',
   'Correct type - json');

$resp = $client->content({
  qry => 'environment',
  format => 'xml',
});

ok($resp, 'Got a response');
isa_ok($resp, 'HTTP::Response');
ok($resp->is_success, 'Successful request');
is($resp->header('Content-type'), 'text/xml; charset=UTF-8',
   'Correct type - xml');
