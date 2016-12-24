use utf8;
package CertChecker::Schema::DB::Result::Domain;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CertChecker::Schema::DB::Result::Domain

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Domains>

=cut

__PACKAGE__->table("Domains");

=head1 ACCESSORS

=head2 uid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 hostname

  data_type: 'text'
  is_nullable: 0

=head2 port

  data_type: 'numeric'
  is_nullable: 0

=head2 certificate

  data_type: 'text'
  is_nullable: 1

=head2 notbefore

  data_type: 'text'
  is_nullable: 1

=head2 notafter

  data_type: 'text'
  is_nullable: 1

=head2 date

  data_type: 'text'
  is_nullable: 0

=head2 requester

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "hostname",
  { data_type => "text", is_nullable => 0 },
  "port",
  { data_type => "numeric", is_nullable => 0 },
  "certificate",
  { data_type => "text", is_nullable => 1 },
  "notbefore",
  { data_type => "text", is_nullable => 1 },
  "notafter",
  { data_type => "text", is_nullable => 1 },
  "date",
  { data_type => "text", is_nullable => 0 },
  "requester",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uid>

=back

=cut

__PACKAGE__->set_primary_key("uid");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-12-24 19:52:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R6fZ3LScilH8o2/Sulg/qg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
