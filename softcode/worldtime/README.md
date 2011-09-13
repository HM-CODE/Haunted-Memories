Here's the +worldtime code in use on HM.

Internal @function dependencies:

* header()
* tail() - like footer() in some places
* msg()

Compatibilities issues:

* Runs on RHOST.
* FN_LOCAL calculates the local timezone and handles MUX and RHOST, but likely needs adjustment for Penn or TM3.
* LINE_ZONE uses timefmt() with RHOSTisms and is not portable but probably easy to fix.

No configuration should be necessary, as it automatically figures out the local zone and adjusts for daylight savings time, etc.  The hilighted "commonly active" timezones can be set in V_COMMON.
