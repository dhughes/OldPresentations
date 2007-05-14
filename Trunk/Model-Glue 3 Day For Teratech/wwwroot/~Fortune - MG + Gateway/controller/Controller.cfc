<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">

	<cffunction name="DoGetCategories" access="public" returnType="void" output="false">
	  <cfargument name="event" type="any">
	  <cfset arguments.event.setValue("categories", getFortuneService().getCategories()) />
	</cffunction>
	
	<cffunction name="DoGetFortune" access="public" returnType="void" output="false">
	  <cfargument name="event" type="any">
	  <cfset arguments.event.setValue("fortune", getFortuneService().getFortune(arguments.event.getValue("categoryId"))) />
	</cffunction>
	
	
	
	<!--- fortuneService --->
    <cffunction name="setFortuneService" access="public" output="false" returntype="void">
       <cfargument name="fortuneService" hint="I am the fortune service" required="yes" type="Fortune.model.service.FortuneService" />
       <cfset variables.fortuneService = arguments.fortuneService />
    </cffunction>
    <cffunction name="getFortuneService" access="public" output="false" returntype="Fortune.model.service.FortuneService">
       <cfreturn variables.fortuneService />
    </cffunction>
</cfcomponent>