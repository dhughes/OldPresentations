<!--- there needs to be a mapping pointing to the presentation's
CfcCrashCourse directory named "CfcCrashCourse" --->

<cfcomponent>

	<cffunction name="getData"
		access="remote"
		hint="I return a query of some data"
		output="false"
		returntype="query">
		<!--- Create the query. This is simply to have
		a query to return.  Typically you would probably
		just use a cfquery.  I didn't want to rely on a
		database connection for a presentation. --->
		<cfset var data = QueryNew("name,description,price")/>
		
		<!--- add a row --->
		<cfset QueryAddRow(data) />
		<cfset QuerySetCell(data, "name", "Widget") />
		<cfset QuerySetCell(data, "description", "A very nice widget.") />
		<cfset QuerySetCell(data, "price", 25) />

		<!--- add another row --->
		<cfset QueryAddRow(data) />
		<cfset QuerySetCell(data, "name", "Gadget") />
		<cfset QuerySetCell(data, "description", "A noticeably admirable Gadget.") />
		<cfset QuerySetCell(data, "price", 18) />
		
		<!--- add one more row --->
		<cfset QueryAddRow(data) />
		<cfset QuerySetCell(data, "name", "Thingamajig") />
		<cfset QuerySetCell(data, "description", "An absolutely dandy Thingamajig.") />
		<cfset QuerySetCell(data, "price", 52) />
		
		<!--- return the query --->
		<cfreturn data />	
	</cffunction>

</cfcomponent>