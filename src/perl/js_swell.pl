#!/usr/bin/perl

use strict;
use JavaScript::Swell;

my $data;
while (<>) {
    $data .= $_;
}
close IN;

print JavaScript::Swell->swell($data);

