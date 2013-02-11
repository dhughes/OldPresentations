<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">
	
	<cffunction name="DoSecureEvent" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		
		<!--- check to see if the current event is NOT secured --->
		<cfif variables.SecurityService.checkIfEventIsSecured(arguments.event.getValue("event"))
			AND NOT variables.SecurityService.userIsLoggedIn()>
			<!--- the event is secure and the user is not logged in --->
			<cfset arguments.event.addResult("ShowLoginForm") />
		</cfif>
		
	</cffunction>
	
	<cffunction name="DoLoginUser" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		
		<cfif variables.SecurityService.loginUser(
			arguments.event.getValue("username"),
			arguments.event.getValue("password"))>
			<!--- sometimes you need to do things you don't want to --->
			<cflocation url="/" addtoken="false" />		
		</cfif>
		
		<cfset arguments.event.addResult("failed") />
	</cffunction>	
	
	<cffunction name="DoLogUserOut" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		
		<cfset variables.SecurityService.loginUserOut() />
		
		<!--- sometimes you need to do things you don't want to --->
		<cflocation url="/" addtoken="false" />		
	</cffunction>	
	
	<cffunction name="DoGetLoggedIn" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		
		<cfset arguments.event.setValue("loggedIn", variables.SecurityService.userIsLoggedIn()) />
		
	</cffunction>

	<cffunction name="setSecurityService" access="public" hint="I set the SecurityService object" output="false" returntype="void">
		<cfargument name="SecurityService" hint="I am the SecurityService object" required="true" type="Security.model.SecurityService" />
		<cfset variables.SecurityService = arguments.SecurityService />
	</cffunction>
	
</cfcomponent>
