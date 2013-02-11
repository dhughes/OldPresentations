<cfcomponent>
	<cfscript>
		this.name="Hackproof_CF"; // The application name.
		this.applicationTimeout=createTimeSpan(1,0,0,0); // Life span, as a real number of days, of the application, including all Application scope variables. Use the CFML CreateTimeSpan function to generate this variable's value.

		this.clientManagement="false"; // Whether the application supports Client scope variables.
		this.clientStorage="cookie"; // Where Client variables are stored; can be cookie, registry, or the name of a data source.

		this.sessionManagement="true"; // Whether the application supports Session scope variables.
		this.sessionTimeout=createTimeSpan(0,1,0,0); // Life span, as a real number of days, of the user session, including all Session variables. Use the CFML CreateTimeSpan function to generate this variable's value.

		//this.scriptProtect="all"; //Whether to protect variables from cross-site scripting attacks.
	</cfscript>

	<!--- on Application Start --->
	<cffunction name="onApplicationStart" output="false">
	</cffunction>

	<!--- on Session Start --->
	<cffunction name="onSessionStart" output="false">
	</cffunction>

	<!--- on Request Start --->
	<cffunction name="onRequestStart" output="false">
		
	</cffunction>



	<!--- on Error --->
	<!--- <cffunction name="onError" output="true">
		<cfargument name="exception" />
		<cfargument name="eventName" type="String" />
		
		<!--- display generic error message --->
		<cfinclude template="/views/error.cfm" />
	</cffunction> --->

	<!--- on Missing Template 
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetPage" required="true" />
	
		<cfinclude template="/error.htm" />
		<cfreturn true />
	</cffunction>
	--->
</cfcomponent>