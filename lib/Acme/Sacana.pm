package Acme::Sacana;
use strict;
use warnings;
use utf8;
our $VERSION = '0.01';

use Smart::Args;
use Class::Accessor::Lite ( ro => [qw( base_name )] );

sub new {
    args my $class     => 'ClassName',
         my $base_name => { isa => 'Str', default => 'さかな' };

    return bless { base_name => $base_name }, $class;
}

my %LIKE = (
    normal   => '%sいいですね',
    wassr    => '%sイイネ!',
    facebook => '%sいいね!',
);

sub like {
    my ($self, $mode) = @_;
    if ( !$mode || $mode !~ /(nomal|wassr|facebook)/ ) {
        $mode = 'normal';
    }
    return sprintf $LIKE{$mode}, $self->base_name;
}

sub want {
    my $self = shift;
    return sprintf '%sたべたい', $self->base_name;
}


1;
__END__

=head1 NAME

Acme::Sacana

=head1 SYNOPSIS

  use Acme::Sacana;
  my $sacana = Acme::Sakana->new;

  $sacana->like;            # => さかないいですね
  $sacana->like('wassr');   # => さかなイイネ!
  $sacana->want;            # => さかなたべたい


=head1 DESCRIPTION

Acme::Sacana is さかなが食べたい時に思いのまま使うモジュール

=head1 AUTHOR

SUZUKI Masashi / masasuzu E<lt>m15.suzuki.masahi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
