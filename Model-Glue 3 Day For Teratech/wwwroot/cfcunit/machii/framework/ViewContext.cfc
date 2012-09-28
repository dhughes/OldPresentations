
<cfcomponent 
	displayname="ViewContext"
	output="false"
	hint="Handles view display for an EventContext.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset setAppManager(arguments.appManager) />
	</cffunction>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="displayView" access="public" returntype="void" output="true">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="contentKey" type="string" required="false" default="" />
		<cfargument name="append" type="boolean" required="false" default="false" />
		
		<cfset var viewPath = getFullPath(arguments.viewName) />
		<cfset var viewContent = "" />
		<cfset request.event = arguments.event />

		<cfif arguments.contentKey is not ''>
			<cfsavecontent variable="viewContent">
				<cfinclude template="#viewPath#" />
			</cfsavecontent>
			<cfif arguments.append and isDefined(arguments.contentKey)>
				<cfset viewContent = evaluate(arguments.contentKey) & viewContent />
			</cfif>
			<cfset setVariable(arguments.contentKey,viewContent) />
		<cfelse>
			<cfinclude template="#viewPath#" />
		</cfif>
	</cffunction>
	
	<!--- PRIVATE FUNCTIONS --->
	<cffunction name="getFullPath" access="private" returntype="string" output="false">
		<cfargument name="viewName" type="string" required="true" />
		
		<cfset var viewPath = getAppManager().getViewManager().getViewPath(arguments.viewName) />
		<cfreturn getAppRoot() & viewPath />
	</cffunction>
	
	<cffunction name="getAppRoot" access="private" returntype="string" output="false">
		<cfreturn getAppManager().getPropertyManager().getProperty('applicationRoot') />
	</cffunction>
	
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>

	<cffunction name="getProperty" access="public" returntype="any" output="false"
		hint="Gets the specified property - this is just a shortcut for getAppManager().getPropertyManager().getProperty()">
		<cfargument name="propertyName" type="string" required="yes"
			hint="The name of the property to return"/>
		<cfif not structKeyExists(variables,"propMgr")>
			<cfset variables.propMgr = getAppManager().getPropertyManager()/>
		</cfif>
		<cfreturn variables.propMgr.getProperty(arguments.propertyName) />
	</cffunction>
	
	<cffunction name="setProperty" access="public" returntype="any" output="false"
		hint="Sets the specified property - this is just a shortcut for getAppManager().getPropertyManager().setProperty()">
		<cfargument name="propertyName" type="string" required="yes"
			hint="The name of the property to set"/>
		<cfargument name="propertyValue" type="any" required="yes" 
			hint="The value to store in the property" />
		<cfif not structKeyExists(variables,"propMgr")>
			<cfset variables.propMgr = getAppManager().getPropertyManager()/>
		</cfif>
		<cfreturn variables.propMgr.setProperty(arguments.propertyName, arguments.propertyValue) />
	</cffunction>
	
</cfcomponent>
