<cfcomponent output="false" hint="I am a Model-Glue controller." extends="ModelGlue.gesture.controller.Controller">

	<cffunction name="init" access="public" output="false" hint="Constructor">
		<cfargument name="framework" />
		
		<cfset super.init(framework) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="onRequestStart">
		<cfquery datasource="#beans.datasource.getDatasource()#">
			SELECT *
			FROM sysobjects
		</cfquery>
	</cffunction>
	
</cfcomponent>
	