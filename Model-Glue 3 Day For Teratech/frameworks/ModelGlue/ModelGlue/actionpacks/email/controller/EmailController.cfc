<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">

	<!--- Autowire / private getter --->
	<cffunction name="setEmailService" access="public" returntype="void" output="false">
		<cfargument name="emailService" required="true" type="any" />
		<cfset variables._svc = arguments.emailService />
	</cffunction>
	<cffunction name="getEmailService" access="private" returntype="any" output="false">
		<cfreturn variables._svc />
	</cffunction>


	<!--- Place the service into the viewstate --->
	<cffunction name="loadEmailService" access="public" returnType="void" output="false">
	  <cfargument name="event" type="any">
	  
	  <cfset arguments.event.setValue("emailService", getEmailService()) />
	</cffunction>
</cfcomponent>