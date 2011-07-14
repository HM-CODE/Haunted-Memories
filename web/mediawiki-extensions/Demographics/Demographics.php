<?php
# Copyright (c) 2008-2011 Kevin Kragenbrink
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

if( !defined( 'MEDIAWIKI' ) ) 
{
	echo( "This is an extension to the MediaWiki package and cannot be run standalone.\n" );
	die( -1 );
}


$wgExtensionCredits['parserhook'][] = array(
	'author'		=> 'Kevin Kragenbrink <kevin@writh.net>',
	'description'	=> 'This extension accesses the stored demograhpics information.',
	'name' 			=> 'Demographics',
	'url'			=> 'http://www.haunted-memories.net/wiki/User:Loki',
	'version'		=> '1.0',
);

// Avoid unstubbing $wgParser on setHook() too early on modern (1.12+) MW versions, as per r35980
if ( defined( 'MW_SUPPORTS_PARSERFIRSTCALLINIT' ) ) 
{
	$wgHooks['ParserFirstCallInit'][] = 'hmDemographicsSetup';
} 
// Otherwise do things the old fashioned way
else 
{ 
	$wgExtensionFunctions[] = 'hmDemographicsSetup';
}


function hmDemographicsSetup()
{
	global $wgParser;
	$wgParser->setHook( 'sphere', 'hmDemographics' );
	return true;
}

function hmDemographics( $input, $args, $parser )
{
	global $wgDBserver, $wgDBname, $wgDBuser, $wgDBpassword;

	$db = new MySQLi( $wgDBserver, $wgDBuser, $wgDBpassword, $wgDBname );

	$spheres = explode( ' ', trim( $input ) );
	$spherecount = 0;

	$query['incl'] = "SELECT `sphere`,`list` FROM `hm_spheres` WHERE `sphere` IN (%s)";
	$query['excl'] = "SELECT `sphere`,`list` FROM `hm_spheres` WHERE `sphere` IN (%s)";
	$list = null;

	$incl = array();
	$excl = array();
	foreach( $spheres AS $n => $sphere  )
	{
		if( substr( $sphere, 0, 1 ) != '!' )
			$incl[] = sprintf( "'%s'", $sphere );
		else
			$excl[] = sprintf( "'%s'", substr( $sphere, 1 ) );
	}
	
	if( count( $excl ) )
		$res2 = $db->query( sprintf( $query['excl'], implode( ',', $excl ) ) );
	$res = $db->query( sprintf( $query['incl'], implode( ',', $incl ) ) );

	if( $res )
	{
		while( $row = $res->fetch_object() )
		{
			if( $list === null )
				$list = explode( ' ', $row->list );
			else
				$list = array_intersect( $list, explode( ' ', $row->list ) );
		}
	}

	if( @$res2 )
	{
		while( $row = $res2->fetch_object() )
		{
			if( $list === null )
				return 0;
			else
				$list = array_diff( $list, explode( ' ', $row->list ) );
		}
	}

	return count( $list );
}
