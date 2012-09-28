<cfcomponent displayname="Controller" output="false" hint="I am a sample model-glue controller." extends="ModelGlue.Core.Controller">

<cffunction name="Init" access="Public" returnType="Controller" output="false" hint="I build a new SampleController">
  <cfargument name="ModelGlue">
  <cfset super.Init(arguments.ModelGlue) />
  <cfreturn this />
</cffunction>

<cffunction name="OnRequestStart" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
	
  <cfreturn arguments.event />
</cffunction>

<cffunction name="OnRequestEnd" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
  <cfreturn arguments.event />
</cffunction>

<cffunction name="CountToNumber" access="Public" returnType="void" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">

	<cfset var number = arguments.event.getValue("number") />
	<cfset var i = "" />
	
	<cfif not isNumeric(number) or number LTE 0>
		<cfthrow message="Hey, you need to enter a non-zero number for this to work!" />
	</cfif>
	
	<cfset arguments.event.setValue("count", 0) />	
	
	<cfloop from="1" to="#number#" index="i">
		<cfset arguments.event.setValue("count", i) />	
	</cfloop>
</cffunction>

<cffunction name="GetCountRequests" access="Public" returnType="void" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">

	<cfset var req = getModelGlue().getAsyncRequests("CountToNumber").GetRequests() />
	<cfset arguments.event.setValue("countRequests", req) />
</cffunction>


<cffunction name="RemoveCount" access="Public" returnType="void" output="false" hint="I am an eventhandler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">

	<cfset var pos = arguments.event.getValue("pos")>
	<cfset var req = getModelGlue().getAsyncRequests("CountToNumber") />

	<cfset arguments.event.trace("RemoveCount", "Removing count #pos# of #arrayLen(req.getRequests())#") />
	<cfif isNumeric(pos)>
		<cfset req.RemoveRequest(pos) />
	</cfif>
</cffunction>

</cfcomponent>

