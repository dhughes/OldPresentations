<cfcomponent name="SecurityService" hint="I am the security service">

	<cfset variables.publicEvents = "" />

	<cffunction name="checkIfEventIsSecured" access="public" hint="I check if an event is secured or not" output="false" returntype="boolean">
		<cfargument name="event" hint="I am the name of the event" required="yes" type="string" />
				
		<cfif ListFindNoCase(getPublicEvents(), event)>
			<cfreturn false />
		</cfif>
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="userIsLoggedIn" access="public" hint="I check if the user is logged in" output="false" returntype="boolean">
		<cfparam name="session.loggedin" default="false" />
		<cfreturn session.loggedin />
	</cffunction>
	
	<cffunction name="loginUser" access="public" hint="I try to log the user in" output="false" returntype="boolean">
		<cfargument name="username" hint="I am the username" required="true" type="string" />
		<cfargument name="password" hint="I am the password" required="true" type="string" />
		<cfparam name="session.loggedin" default="false" />
		
		<!--- clearly security should be more indepth than THIS --->
		<cfif arguments.username IS "foo" and arguments.password IS "bar">
			<cfset session.loggedin = true />
		</cfif>
		
		<cfreturn session.loggedin />
	</cffunction>
	
	<cffunction name="loginUserOut" access="public" hint="I try to log the user out" output="false" returntype="void">
		<cfset session.loggedin = false />
	</cffunction>
	
	<cffunction name="getPublicEvents" access="public" hint="Getter for publicEvents" output="false" returnType="string">
		<cfreturn variables.publicEvents />
	</cffunction>

	<cffunction name="setPublicEvents" access="public" hint="Setter for publicEvents" output="false" returnType="void">
		<cfargument name="publicEvents" hint="I am a comma seperated list of public events" required="yes" type="string" />
		<cfset variables.publicEvents = arguments.publicEvents />
	</cffunction>

</cfcomponent>