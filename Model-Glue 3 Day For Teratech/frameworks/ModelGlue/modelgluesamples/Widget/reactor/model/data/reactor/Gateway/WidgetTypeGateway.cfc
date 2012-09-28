
<cfcomponent hint="I am the database agnostic custom Gateway object for the WidgetType object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.widgetreactor.Gateway.WidgetTypeGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
<cffunction name="listWidgetCount" returntype="query" output="false">
	<cfset var result = "" />

	<cfquery name="result" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
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
	
