<cfcomponent displayname="Controller" extends="ModelGlue.unity.controller.Controller" output="false">

	<cfset variables.Fortune = CreateObject("Component", "Fortune - Simple MG.model.Fortune").init("Fortune", "", "") />

	<cffunction name="DoGetCategories" access="public" returnType="void" output="false">
	  <cfargument name="event" type="any">
	  
	  <cfset arguments.event.setValue("categories", variables.Fortune.getCategories()) />
	</cffunction>
	
	<cffunction name="DoGetFortune" access="public" returnType="void" output="false">
	  <cfargument name="event" type="any">
	  
	  <cfset arguments.event.setValue("fortune",
	  		variables.Fortune.getFortune(
	  			arguments.event.getValue("categoryId")
	  		)
	  	) />
	</cffunction>
	
</cfcomponent>