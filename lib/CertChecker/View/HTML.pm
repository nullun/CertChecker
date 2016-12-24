package CertChecker::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION => '.tt',
	render_die         => 1,
	INCLUDE_PATH       => CertChecker->path_to('root', 'src'),
	WRAPPER            => 'wrapper.tt',
);

=head1 NAME

CertChecker::View::HTML - TT View for CertChecker

=head1 DESCRIPTION

TT View for CertChecker.

=head1 SEE ALSO

L<CertChecker>

=head1 AUTHOR

Steve,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
