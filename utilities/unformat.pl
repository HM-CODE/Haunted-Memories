#! /usr/bin/perl -w
#
# Copyright (c) 2010-2011 Emily Backes
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#
#     * Neither the name of the author nor the names of other
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

use strict;
use warnings;

my $state = {};

sub slurp {
    my ($name) = @_;
    local $/;
    my $data;
    if ($name eq '-') {
	$data = <STDIN>;
    } else {
	open FILE, '<', $name or die "open: $name: $!\n";
	$data = <FILE>;
	close FILE;
    }
    $data
}

sub init_state {
    $state->{line} = '';
    $state->{output} = '';
}

sub process {
    my ($data) = @_;
    $data =~ s/[^\t\r\n -~]//gsm;
    $data =~ s/\t/ /gsm;
    $data =~ s/[\r\n]+/\n/gsm;
    my @lines = split /\n/,$data;
    for (@lines) {
	next if (/^\#/);
	next if (/^\s*$/);
	if (/^-\s*$/) {
	    local $_ = $state->{line};

	    s/\s+/ /gsm;
	    s/^\s+//;
	    s/\s+$//;

	    die "suspicious output: $_\n"
	      unless (/^[\@\&]|think\s*/);

	    $state->{output} .= "$_\n";
	    $state->{line} = '';
	    next;
	}
	if (/^QUIT$/ and $state->{line} eq "") {
	    next;
	}

	s/^\s+//;
	s/\\\s*$//;
	
	$state->{line} .= "$_";
    }
    die "unterminated output line block\n"
      if ($state->{line});
}

init_state();
if (@ARGV) { for (@ARGV) { process(slurp($_)); }}
else { process(slurp('-')); }
print $state->{output};
