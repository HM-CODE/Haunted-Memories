This is the development repository for Haunted Memories.  It is not intended to be used on other MUSHes, although some of the code is likely reusable.

Please contact Loki on haunted-memories.net port 3010 before using this code.

# Repository Layout
	/hardcode		Contains patches to the RhostMUSH core.
	/projects		Contains one directory per softcode project.
	  ./<project>	Contains one file (with the .mush extension) per game object.
	/utilities		Utility binaries and scripts, such as format/unformat tools.
	/web			Website extensions and tools.

# Instructions for HM Developers
	1.	Fork this Repository to create your own local branch.
	2.	Code in formatted (expanded) format; use the unformatter in /utilities to compile your code for use.
	3.	Test your code thoroughly on the Development port.
	4.	Make a build script which will compile your code and output notes on how your code should be implemented.
	5.	Send a pull-request when you are ready to have your code reviewed for inclusion back in the MUSH.
