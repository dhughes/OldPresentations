<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="Event"
	output="false"
	hint="Base Event component.">

	<!--- PROPERTIES --->
	<cfset variables.name = "" />
	<cfset variables.args = StructNew() />
	<cfset variables.argTypes = StructNew() />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="args" type="struct" required="false" default="#StructNew()#" />
		
		<cfset setName(arguments.name) />
		<cfset setArgs(arguments.args) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.name = arguments.name />
	</cffunction>
	
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.name />
	</cffunction>
	
	<cffunction name="setArg" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />
		<cfargument name="argType" type="string" required="false" />
		
		<cfset variables.args[arguments.name] = arguments.value />
		<cfif StructKeyExists(arguments, 'argType')>
			<cfset setArgType(arguments.name, arguments.argType) />
		</cfif>
	</cffunction>

	<cffunction name="getArg" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="defaultValue" type="any" required="false" default="" />
		
		<cfif StructKeyExists(variables.args, arguments.name)>
			<cfreturn variables.args[arguments.name] />
		<cfelse>
			<cfreturn arguments.defaultValue />
		</cfif>
	</cffunction>

	<cffunction name="isArgDefined" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfreturn StructKeyExists(variables.args, arguments.name) />
	</cffunction>
	
	<cffunction name="removeArg" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset StructDelete(variables.args, arguments.name) />
	</cffunction>
	
	<cffunction name="setArgs" access="public" returntype="void" output="false">
		<cfargument name="args" type="struct" required="true" />
		<cfset var key = 0 />
		<cfloop collection="#arguments.args#" item="key">
			<cfset setArg(key, arguments.args[key]) />
		</cfloop>
	</cffunction>
	
	<cffunction name="getArgs" access="public" returntype="struct" output="false">
		<cfreturn variables.args />
	</cffunction>
	
	<cffunction name="setArgType" access="public" returntype="void" output="false">
		<cfargument name="argName" type="string" required="true" />
		<cfargument name="argType" type="string" required="true" />
		<cfset variables.argTypes[arguments.argName] = arguments.argType />
	</cffunction>
	
	<cffunction name="getArgType" access="public" returntype="string" output="false">
		<cfargument name="argName" type="string" required="true" />
		<cfif StructKeyExists(variables.argTypes, arguments.argName)>
			<cfreturn variables.argTypes[arguments.argName] />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

</cfcomponent>
