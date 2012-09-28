
<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">
	
	<cffunction name="DoGetCode" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		 
		<cfset arguments.event.setValue("code", createUUID()) />
		 
	</cffunction>
	
	<cffunction name="DoCheckCode" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		 
		<cfif arguments.event.getValue("requiredCode") IS arguments.event.getValue("providedCode")>
			<cfset arguments.event.addResult("Match") />
		<cfelse>
			<cfset arguments.event.setValue("matchFailed", true) />
			<cfset arguments.event.addResult("NoMatch") />
		</cfif>
		 
	</cffunction>

</cfcomponent>