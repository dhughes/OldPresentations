<cfcomponent output="false">

<cffunction name="init" output="false">
	<cfargument name="datasource" />
	
	<cfset variables._ds = arguments.datasource />
	
	<cfreturn this />
</cffunction>	

<cffunction name="listWidgetCount" returntype="query" output="false">
	<cfset var result = "" />

	<cfquery name="result" datasource="#variables._ds.getDsn()#" username="#variables._ds.getUsername()#" password="#variables._ds.getPassword()#">
		SELECT
			wt.widgetTypeId,
			wt.name,
			COUNT(widgetId) as widgetCount
		FROM
			widgetType wt
			JOIN widget w ON wt.widgetTypeId = w.widgetTypeId
		GROUP BY
			wt.widgetTypeId,
			wt.name
		ORDER BY
			wt.name
	</cfquery>	
	
	<cfreturn result />			
</cffunction>

</cfcomponent>
	
