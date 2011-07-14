Here's the init code in use on HM.

Note that this source includes the demo commands on:

* CMD_INIT_DEMO
* CMD_INIT_DEMO2
* CMD_INIT_DEMO3

Those should be removed before production use.

Current code is RHOST compatible and _almost_ compatible with other MUSH servers.  The critical things to look at are use of strfunc() and elist().  MUX has no strfunc() yet, so that code needs refactoring for portability, and elist() should be replaced with itemize() there.  Patches adding detection and portability are quite welcome.

No side-effects or substitution-based colors are used.

See the _External Data Interface_ section for attributes that need replacing for the local environment:

* FN_GET_INIT
* FN_GET_STAT
* FN_LOCATION_IC

Internal @function dependencies:

* msg()
* moniker() - not normally present on RHOST but should work like the MUX one

Consider replacing:

* FN_HEADER
* FN_DIVIDER
* FN_FOOTER

