
<cfcomponent 
	displayname="FilterManager"
	output="false"
	hint="Manages registered EventFilters for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.filters = StructNew() />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var filterNodes = "" />
		<cfset var filterParams = "" />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var name = 0 />
		<cfset var type = 0 />
		<cfset var paramNodes = 0 />
		<cfset var paramName = 0 />
		<cfset var paramValue = 0 />
		<cfset var filter = 0 />
		
		<cfset setAppManager(arguments.appManager) />

		<!--- Setup up each EventFilter. --->
		<cfset filterNodes = XMLSearch(configXML,"//event-filters/event-filter") />
		<cfloop from="1" to="#ArrayLen(filterNodes)#" index="i">
			<cfset name = filterNodes[i].xmlAttributes['name'] />
			<cfset type = filterNodes[i].xmlAttributes['type'] />
		
			<!--- Set the EventFilter's parameters. --->
			<cfset filterParams = StructNew() />
			<cfset paramNodes = XMLSearch(filterNodes[i], "./parameters/parameter") />
			<cfloop from="1" to="#ArrayLen(paramNodes)#" index="j">
				<cfset paramName = paramNodes[j].xmlAttributes['name'] />
				<cfset paramValue = paramNodes[j].xmlAttributes['value'] />
				<cfset filterParams[paramName] = paramValue />
			</cfloop>
			
			<cfset filter = CreateObject('component', type) />
			<cfset filter.init(arguments.appManager, filterParams) />
			
			<cfset addFilter(name, filter) />
		</cfloop> 
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void">
		<cfset var key = 0 />
		<cfloop collection="#variables.filters#" item="key">
			<cfset getFilter(key).configure() />
		</cfloop>
	</cffunction>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="addFilter" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true">
		<cfargument name="filter" type="cfcunit.machii.framework.EventFilter" required="true">
		
		<cfset variables.filters[arguments.name] = arguments.filter />
	</cffunction>
	
	<cffunction name="getFilter" access="public" returntype="cfcunit.machii.framework.EventFilter" output="false">
		<cfargument name="filterName" type="string" required="true">
		
		<cfif isFilterDefined(arguments.filterName)>
			<cfreturn variables.filters[arguments.filterName] />
		<cfelse>
			<cfthrow type="FilterNotDefined" message="Filter with name #arguments.filterName# is not defined." errorcode="1030" />
		</cfif>
	</cffunction>
	
	<cffunction name="isFilterDefined" access="public" returntype="boolean" output="false">
		<cfargument name="filterName" type="string" required="true" />
		<cfreturn StructKeyExists(variables.filters, arguments.filterName) />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
	
</cfcomponent>
