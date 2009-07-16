<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">
	
	<cffunction name="DoHandleException" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		
		<cfif variables.ExceptionService.getDebug()>
			<cfset arguments.event.addResult("DisplayError") />
		<cfelse>
			<!--- send an email about this to someone who cares --->
			<cfset variables.ExceptionService.handleException(duplicate(arguments.event.getValue("exception"))) />
			<cfset arguments.event.addResult("FriendlyError") />
		</cfif>
		
	</cffunction>


	<cffunction name="setExceptionService" access="public" hint="I set the ExceptionService object" output="false" returntype="void">
		<cfargument name="ExceptionService" hint="I am the ExceptionService object" required="true" type="Exception.model.ExceptionService" />
		<cfset variables.ExceptionService = arguments.ExceptionService />
	</cffunction>
	
</cfcomponent>
