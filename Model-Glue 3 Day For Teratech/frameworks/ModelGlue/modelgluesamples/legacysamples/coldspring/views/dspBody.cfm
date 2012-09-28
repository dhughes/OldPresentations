<cfset tf = viewstate.getValue("timeFormat") />
<cfoutput>
Using <a href="http://cfopen.org/projects/coldspring/">ColdSpring</a>, I know that my TimeFormat is #tf#, and that the current time is #timeFormat(now(), tf)#.
</cfoutput>