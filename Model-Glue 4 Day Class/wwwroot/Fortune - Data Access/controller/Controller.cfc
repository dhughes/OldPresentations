<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">

	<cfset variables.Fortune = CreateObject("Component", "Fortune - Data Access.model.Fortune").init("Fortune", "", "") />

	<cffunction name="DoGetCategories" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset arguments.event.setValue("categories", variables.Fortune.getCategories()) />
	</cffunction>
	
	<cffunction name="DoGetFortune" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset var defaultCategoryId = arguments.event.getArgument("defaultCategoryId") />
		<cfset var categoryId = arguments.event.getValue("categoryId", defaultCategoryId) />
		<cfset arguments.event.setValue("fortune", variables.Fortune.getFortune(categoryId)) />
	</cffunction>
	
	<cffunction name="DoLogFortune" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset variables.Fortune.logFortune(arguments.event.getValue("fortune")) />
	</cffunction>
	
	<cffunction name="DoGetRecentFortunes" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset var max = arguments.event.getArgument("max") />
		<cfset arguments.event.setValue("fortunes", variables.Fortune.getRecentFortunes(max)) />
	</cffunction>
	
	
	
</cfcomponent>