<cfcomponent displayname="GeneratedView" output="false">

<cffunction name="init" returntype="ModelGlue.unity.eventhandler.generatedView" output="false">
	<cfargument name="name" type="string" required="true" />
	<cfargument name="xsl" type="string" required="true" />
	<cfargument name="prefix" type="string" required="true" />
	<cfargument name="suffix" type="string" required="true" />
	
	<cfset variables._name = arguments.name />
	<cfset variables._xsl = arguments.xsl />
	<cfset variables._prefix = arguments.prefix />
	<cfset variables._suffix = arguments.suffix />
	
	<cfreturn this />
</cffunction>

<cffunction name="getName" returntype="string" access="public" output="false">
	<cfreturn variables._name />
</cffunction>

<cffunction name="getXsl" returntype="string" access="public" output="false">
	<cfreturn variables._xsl />
</cffunction>

<cffunction name="getPrefix" returntype="string" access="public" output="false">
	<cfreturn variables._prefix />
</cffunction>

<cffunction name="getSuffix" returntype="string" access="public" output="false">
	<cfreturn variables._suffix />
</cffunction>

</cfcomponent>