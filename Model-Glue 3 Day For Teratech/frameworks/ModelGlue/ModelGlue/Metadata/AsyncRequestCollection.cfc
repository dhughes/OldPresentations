<cfcomponent name="AsyncRequestCollection" output="false" hint="I represent a collection of AsyncRequest instances.">

<cffunction name="Init" output="false" returnType="ModelGlue.Metadata.AsyncRequestCollection" hint="Constructor">
	<cfset variables.req = arrayNew(1) />
	<cfreturn this />
</cffunction>

<cffunction name="Add" output="false" returnType="void">
	<cfargument name="EventRequest" type="ModelGlue.Metadata.AsyncRequest" required="true">
	<cfset arrayAppend(variables.req, arguments.EventRequest) />
</cffunction>

<cffunction name="GetRequests" output="false" returnType="array">
	<cfreturn variables.req />
</cffunction>

<cffunction name="RemoveRequest" output="false" returnType="void">
	<cfargument name="position" type="numeric" required="true" hint="The position of the request to remove in the request array returned by GetRequests()" />

	<cfif arguments.position gt 0 and arguments.position lte arrayLen(variables.req)>
		<cfset arrayDeleteAt(variables.req, arguments.position) />
	</cfif>

	<cfreturn  />
</cffunction>

</cfcomponent>