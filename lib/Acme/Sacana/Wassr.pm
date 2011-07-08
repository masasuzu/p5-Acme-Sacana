package Acme::Sacana::Wassr;
use warnings;
use strict;
use utf8;
use parent 'Acme::Sacana';

use Carp;
use Class::Accessor::Lite ( ro => [qw( base_name )] );
use JSON;
use Smart::Args;
use LWP::UserAgent;

my $API_URI = 'http://api.wassr.jp/statuses/update.json';

sub new {
    args my $class     => 'ClassName',
         my $base_name => { isa => 'Str', default => 'さかな' },
         my $user      => 'Str',
         my $password  => 'Str';

    my $ua = LWP::UserAgent->new;
    $ua->agent($class);
    $ua->credentials('api.wassr.jp:80', 'API Authentication', $user, $password);
    $ua->env_proxy;

    return bless {
        base_name => $base_name,
        __ua      => $ua,
    }, $class;
}

sub _post {
    my ($self, $status) = @_;
    my $response = $self->{__ua}->post($API_URI, { status => $status, source => ref $self });
    croak 'Bad Request: ', $response->as_string if not $response->is_success;

    my $content = decode_json($response->decoded_content);
    croak 'Bad Response: ', $content->{error} if $content->{error};

    return $status;
}

sub like {
    my ($self, $mode) = @_;
    my $status = $self->SUPER::like($mode);
    $self->_post($status);
}

sub want {
    my $self = shift;
    my $status = $self->SUPER::want;
    $self->_post($status);
}

1;
