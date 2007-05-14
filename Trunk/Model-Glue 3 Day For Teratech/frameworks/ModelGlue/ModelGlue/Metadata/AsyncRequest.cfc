<cfcomponent name="AsyncRequest" output="false" hint="I represent an AsyncRequest.">

<cffunction name="Init" output="false" returnType="ModelGlue.Metadata.AsyncRequest" hint="Constructor">
	<cfargument name="futureTask" type="Concurrency.FutureTask">
	<cfargument name="event" type="ModelGlue.Core.Event">

	<cfset variables.future = arguments.futureTask />
	<cfset variables.event = arguments.event />
	<cfset variables.createdOn = now() />

	<cfreturn this />
</cffunction>

<cffunction name="GetFuture" output="false" returnType="Concurrency.FutureTask">
	<cfreturn variables.future />
</cffunction>

<cffunction name="GetEvent" output="false" returnType="ModelGlue.Core.Event">
	<cfreturn variables.event />
</cffunction>

<cffunction name="GetCreatedOn" output="false" returnType="date">
	<cfreturn variables.createdOn />
</cffunction>

<cffunction name="IsDone" output="false" returnType="boolean">
	<cfreturn GetFuture().IsDone() />
</cffunction>

</cfcomponent>