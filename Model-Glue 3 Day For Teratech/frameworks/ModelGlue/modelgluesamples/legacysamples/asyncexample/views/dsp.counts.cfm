<meta http-equiv="refresh" content="1;url=index.cfm?event=counts">

<cfset requests = viewState.getValue("countRequests") />

<a href="index.cfm?event=counts">Reload</a>

Currently running counts:

<cfloop from="1" to="#arrayLen(requests)#" index="i">
	<cfset event = requests[i].getEvent() />
	<cfset count = event.getValue("count") />
	<cfset number = event.getValue("number") />
	<cfoutput>
	<cfif isNumeric(count) and isNumeric(number)>
		<div style="background:##CCCCCC;width:#count/number*100#%">&nbsp;</div>
	<cfelse>
		<div style="background:##CCCCCC;width:0%">&nbsp;</div>
	</cfif>
		#count# / #number#
		<a href="index.cfm?event=removeCount&pos=#i#">Remove</a>
		</div>
	</cfoutput>
</cfloop>


