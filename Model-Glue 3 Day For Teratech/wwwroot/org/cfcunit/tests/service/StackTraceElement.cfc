<cfcomponent name="StackTraceElement" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="init" returntype="StackTraceElement" access="public" output="false">
		<cfargument name="filename" type="string" required="true"/>
		<cfargument name="lineNumber" type="numeric" required="true"/>
		<cfargument name="className" type="string" required="true"/>
		<cfargument name="methodName" type="string" required="true"/>
		
		<cfset variables.filename = arguments.filename>
		<cfset variables.lineNumber = arguments.lineNumber>
		<cfset variables.className = arguments.className>
		<cfset variables.methodName = arguments.methodName>

		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getFilename" returntype="string" access="public" output="false">
		<cfreturn variables.filename/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="getLineNumber" returntype="numeric" access="public" output="false">
		<cfreturn variables.lineNumber/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="getClassName" returntype="string" access="public" output="false">
		<cfreturn variables.className/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="getMethodName" returntype="string" access="public" output="false">
		<cfreturn variables.methodName/>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>

</cfcomponent>