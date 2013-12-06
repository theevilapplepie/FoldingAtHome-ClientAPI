#!/usr/bin/perl

push @INC, './';

use warnings;
use strict;
use FoldingAtHome::ClientAPI;
use Data::Dumper;

my $fahstat = FoldingAtHome::ClientAPI->new();

my $options = $fahstat->api_options();
print "\n** Dumping from api_options\n".Dumper($options);
my $info = $fahstat->api_info();
print "\n** Dumping from api_info\n".Dumper($info);
my $queue = $fahstat->api_queue();
print "\n** Dumping from api_queue\n".Dumper($queue);
my $slots = $fahstat->api_slots();
print "\n** Dumping from api_slots\n".Dumper($slots);
