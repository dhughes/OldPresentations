<cfcomponent displayName="Controller" output="false" hint="I am the base for any Model-Glue controllers." extends="ModelGlue.unity.controller.Controller">

<!--- Just a shell used for typing for reverse compatibility. --->


<cffunction name="Init" access="public" returnType="ModelGlue.Core.Controller" output="false" hint="I return a new Controller.">
  <cfargument name="ModelGlue" type="ModelGlue.unity.framework.ModelGlue" required="true" hint="I am an instance of ModelGlue.">
  <cfargument name="name" type="string" required="false" default="#createUUID()#" hint="A name for this controller.">

	<cfset super.init(arguments.ModelGlue, arguments.name) />

  <cfreturn this />
</cffunction>
	
</cfcomponent>