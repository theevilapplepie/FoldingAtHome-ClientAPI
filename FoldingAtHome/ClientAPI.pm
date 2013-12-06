package FoldingAtHome::ClientAPI;

use warnings;
use strict;
use Carp;
use JSON::XS;
use Net::Telnet;
require Exporter;

# Var Setup
our $VERSION = 0.1;
use base qw(Exporter);

# Available Functions
sub new {
  my $class = shift;
  if ( ! defined($class) || $class ne 'FoldingAtHome::ClientAPI') {
    croak 'ERROR! : Module FoldingAtHome::ClientAPI MUST be initalized by FoldingAtHome::ClientAPI->new(), You cannot call the new function directly.\n';
  }
  my $args = shift;
  my $server;
  my $port;
  my $verbose;
  if ( ! defined($args->{'server'}) ) {
    $server = '127.0.0.1';
  } else {
    $server = $args->{'server'};
  };
  if ( ! defined($args->{'port'}) ) {
    $port = '36330';
  } else {
    $port = $args->{'port'};
  };
  if ( ! defined($args->{'verbose'}) ) {
    $verbose = '0';
  } else {
    $verbose = $args->{'verbose'};
  };
  my $self = {
    server => $server,
    port => $port,
    verbose => $verbose,
  };
  bless $self, $class;
  return $self;
}

# Interal Functions
sub connect_api {
  my $self = shift;
  my $server = $self->{'server'};
  my $port = $self->{'port'};
  if ( ! defined $server || ! defined $port ) {
    if ( $self->{'verbose'} ) { print 'Server/Port not defined to connect_api, Returning false.'; };
    return;
  }
  my $t = Net::Telnet->new( Timeout => 10, Prompt => '/\n>/', Port => $port, Errmode => 'return' );
  if ( ! $t->open($server) ) {
    if ( $self->{'verbose'} ) { print 'Unable to connect to server, Returning false.'; };
    return;
  }
  $t->waitfor('/\n>/');
  return $t;
}

sub run_apicommand {
  my $self = shift;
  my $command = shift;
  my $t = $self->connect_api;
  $t->buffer_empty;
  my @output = $t->cmd($command);
  my $stroutput;
  for my $line (@output) {
    $stroutput .= $line;
  }
  @output = $t->cmd('exit');
  $stroutput =~ s/\n---//xms;
  $stroutput =~ s/^PyON[^\n]+\n//xms;
  return (JSON::XS->new->allow_nonref->decode($stroutput));
}

sub api_options {
  my $self = shift;
  my $obj = $self->run_apicommand('options');
  return $obj;
}

sub api_info {
  my $self = shift;
  my $obj = $self->run_apicommand('info');
  my %returnarr;
  foreach my $objs (@{$obj}) {
    my $category;
    foreach my $obj (@{$objs}) {
      if ( ref($obj) ne 'ARRAY' ) {
        $category = $obj;
      } else {
        $returnarr{$category}{@{$obj}[0]} = @{$obj}[1];
      }
    }
  }
  $returnarr{'System'}{'PPD'} = $self->internal_api_ppd();
  return ({%returnarr});
}

sub api_slots {
  my $self = shift;
  my $obj = $self->run_apicommand('slot-info');
  return $obj;
}

sub api_queue {
  my $self = shift;
  my $obj = $self->run_apicommand('queue-info');
  return $obj;
}
sub internal_api_ppd {
  my $self = shift;
  my $obj = $self->run_apicommand('ppd');
  return $obj;
}

1;

