<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">

	<cffunction name="DoGetCategories" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset arguments.event.setValue("categories", getFortuneService().getCategories()) />
	</cffunction>
	
	<cffunction name="DoGetFortune" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset var defaultCategoryId = arguments.event.getArgument("defaultCategoryId") />
		<cfset var categoryId = arguments.event.getValue("categoryId", defaultCategoryId) />
		<cfset arguments.event.setValue("fortune", getFortuneService().getFortune(categoryId)) />
	</cffunction>
	
	<cffunction name="DoLogFortune" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset getFortuneService().logFortune(arguments.event.getValue("fortune")) />
	</cffunction>
	
	<cffunction name="DoGetRecentFortunes" access="public" returnType="void" output="false">
		<cfargument name="event" type="any">
		<cfset var max = arguments.event.getArgument("max") />
		<cfset arguments.event.setValue("fortunes", getFortuneService().getRecentFortunes(max)) />
	</cffunction>
	
	<!--- fortuneService --->
    <cffunction name="setFortuneService" access="public" output="false" returntype="void">
       <cfargument name="fortuneService" hint="I am the service to use to get fortune data." required="yes" type="Fortune - ColdSpring.model.FortuneService" />
       <cfset variables.fortuneService = arguments.fortuneService />
    </cffunction>
    <cffunction name="getFortuneService" access="public" output="false" returntype="Fortune - ColdSpring.model.FortuneService">
       <cfreturn variables.fortuneService />
    </cffunction>
	
</cfcomponent>