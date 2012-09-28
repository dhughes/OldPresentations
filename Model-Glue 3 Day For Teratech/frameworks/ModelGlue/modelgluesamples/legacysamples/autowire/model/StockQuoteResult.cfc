<cfcomponent>
	<cffunction name="init">
		<cfset variables.errors = createObject("component", "ModelGlue.Util.ValidationErrorCollection") />
		<cfset variables.result = "" />
		<cfset variables.symbol = "" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="AddError">
		<cfargument name="Property">
		<cfargument name="Message">
		<cfset variables.errors.addError(arguments.property, arguments.message) />
	</cffunction>
	
	<cffunction name="GetErrors">
		<cfreturn variables.errors.getErrors() />
	</cffunction>
	
	<cffunction name="setResult">
		<cfargument name="value">
		<cfset variables.result = arguments.value />
	</cffunction>
	
	<cffunction name="getResult">
		<cfreturn variables.result />
	</cffunction>
	
	<cffunction name="setSymbol">
		<cfargument name="value">
		<cfset variables.symbol = arguments.value />
	</cffunction>

	<cffunction name="getSymbol">
		<cfreturn variables.symbol />
	</cffunction>
</cfcomponent>