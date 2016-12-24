package CertChecker::Controller::Root;
use Moose;
use namespace::autoclean;
use DateTime;
#use Net::SSLeay qw/sslcat X509_get_notBefore X509_get_notAfter P_ASN1_TIME_get_isotime/;
use Net::SSLeay qw/sslcat/;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

CertChecker::Controller::Root - Root Controller for CertChecker

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
	my ( $self, $c ) = @_;

	$c->stash->{page_title} = 'Enter a new domain';

	$c->detach();
}

sub check :Local :Args(0) {
	my ($self, $c) = @_;

	my $host = $c->request->params->{host};
	my $port = $c->request->params->{port} || 443;

	# Validate Host and Port
#	unless($host =~ m/^[a-zA-Z0-9][a-zA-Z0-9-_]{0,61}[a-zA-Z0-9]{0,1}\.([a-zA-Z]{1,6}|[a-zA-Z0-9-]{1,30}\.[a-zA-Z]{2,3})$/) {
	unless($host =~ m/^([a-zA-Z0-9]+\.)+[a-zA-Z]+$/) {
		$c->stash->{warning_message} = 'Input is either invalid or I don\'t support it (yet)';
		$c->stash->{template} = 'index.tt';
		$c->detach();
	}
	
	unless($port =~ m/^([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$/) {
		$c->stash->{warning_message} = 'Invalid port number. If you\'re unsure of the port number, leave it blank. (Default: 443)';
		$c->stash->{template} = 'index.tt';
		$c->detach();
	}
	
	my ($reply, $err, $cert) = sslcat($host, $port, '/');

	if ($err) {
		$c->stash->{warning_message} = 'Host unavailable';
		$c->stash->{template} = 'index.tt';
		$c->detach();
	}

	if (!defined $cert) {
		$c->stash->{warning_message} = 'No certificate found';
		$c->stash->{template} = 'index.tt';
		$c->detach();
	}

	# Populate variables we need in the view.
	$c->stash->{host} = $host;
	$c->stash->{port} = $port;
	$c->stash->{notBefore} = Net::SSLeay::P_ASN1_TIME_get_isotime(Net::SSLeay::X509_get_notBefore($cert)) || 'null';
	$c->stash->{notAfter} = Net::SSLeay::P_ASN1_TIME_get_isotime(Net::SSLeay::X509_get_notAfter($cert)) || 'null';

	# Save to database.
	my $rs = $c->model('DB::Domain');
	my $result = $rs->create(
		{
			hostname    => $c->stash->{host},
			port        => $c->stash->{port},
			certificate => Net::SSLeay::PEM_get_string_X509($cert),
			notbefore   => $c->stash->{notBefore},
			notafter    => $c->stash->{notAfter},
			date        => DateTime->now,
			requester   => $c->request->address,
		},
	);

	$c->detach();
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Steve,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
