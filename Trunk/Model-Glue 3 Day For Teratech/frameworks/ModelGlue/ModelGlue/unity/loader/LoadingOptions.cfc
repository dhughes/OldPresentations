<cfcomponent displayname="LoadingOptions" hint="I contain options related to partial reloading of the framework.">

<cfset variables.rescaffold = false />

<cffunction name="init" output="false">
	<cfreturn this />
</cffunction>

<cffunction name="SetRescaffold" output="false" hint="I set whether or not the framework should re-generate scaffold XML and view code.">
	<cfargument name="rescaffold" type="boolean" required="true" />
	<cfset variables.rescaffold = arguments.rescaffold />
</cffunction>

<cffunction name="GetRescaffold" output="false" hint="I get whether or not the framework should re-generate scaffold XML and view code.">
	<cfreturn variables.rescaffold />
</cffunction>

</cfcomponent>