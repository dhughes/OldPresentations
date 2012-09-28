
<cfcomponent 
	displayname="ViewManager"
	output="false"
	hint="Manages registered views for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.viewPaths = StructNew() />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var viewNodes = "" />
		<cfset var i = 0 />
		<cfset var name = "" />
		<cfset var page = "" />
		
		<cfset setAppManager(arguments.appManager) />

		<!--- Setup up each Page-View. --->
		<cfset viewNodes = XMLSearch(configXML,"//page-views/page-view") />
		<cfloop from="1" to="#ArrayLen(viewNodes)#" index="i">
			<cfset name = viewNodes[i].xmlAttributes['name'] />
			<cfset page = viewNodes[i].xmlAttributes['page'] />
			
			<cfset variables.viewPaths[name] = page />
		</cfloop> 
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void">
		<!--- DO NOTHING --->
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="getViewPath" access="public" returntype="string" output="false">
		<cfargument name="viewName" type="string" required="true">
		
		<cfif isViewDefined(arguments.viewName)>
			<cfreturn variables.viewPaths[arguments.viewName] />
		<cfelse>
			<cfthrow type="ViewNotDefined" message="View with name #arguments.viewName# is not defined." errorcode="1020" />
		</cfif>
	</cffunction>
	
	<cffunction name="isViewDefined" access="public" returntype="boolean" output="false">
		<cfargument name="viewName" type="string" required="true" />
		<cfreturn StructKeyExists(variables.viewPaths, arguments.viewName) />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
</cfcomponent>