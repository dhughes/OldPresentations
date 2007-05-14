<cfcomponent displayname="Config" extends="ModelGlue.Util.GenericCollection">

<cffunction name="Init" access="public" output="false" hint="Constructor">
	<cfset super.Init() />

	<cfset setValue("defaultEvent" ,"Home") />
	<cfset setValue("reload" ,"true") />
	<cfset setValue("reloadKey" ,"init") />
	<cfset setValue("reloadPassword" ,"true") />
	<cfset setValue("statePrecedence" ,"Form") />
	<cfset setValue("eventValue" ,"event") />
	<cfset setValue("self" ,"index.cfm") />
	<cfset setValue("defaultExceptionHandler" ,"Exception") />
	<cfset setValue("debug" ,"true") />
	<cfset setValue("defaultCacheTimeout" ,"5") />
	<cfset setValue("stateBuilder" ,"ModelGlue.Util.GenericCollection") />
	<cfset setValue("beanFactoryLoader" ,"ModelGlue.Core.ChiliBeansLoader") />
	<cfset setValue("autowireControllers", "false") />
	<cfreturn this />
</cffunction>

</cfcomponent>