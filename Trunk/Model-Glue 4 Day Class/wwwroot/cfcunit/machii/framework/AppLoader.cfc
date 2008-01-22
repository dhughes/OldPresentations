
<cfcomponent 
	displayname="AppLoader" 
	output="false"
	hint="Responsible for controlling loading/reloading of the AppManager.">
	
	<!--- PROPERTIES --->
	<cfset variables.configPath = "" />
	<cfset variables.appManager = "" />
	<cfset variables.appFactory = "" />
	<cfset variables.lastReloadDate = CreateDateTime('1970','01','01','00','00','00') />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="cfcunit.machii.framework.AppLoader" output="true">
		<cfargument name="configPath" type="string" required="true" />
		
		<cfset var appFactory = CreateObject('component', 'cfcunit.machii.framework.AppFactory') />
		<cfset appFactory.init() />
		<cfset setAppFactory(appFactory) />
		
		<cfset setConfigPath(arguments.configPath) />
		<cfset reloadConfig() />
		
		<cfreturn this />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="shouldReloadConfig" access="public" returntype="boolean" output="false">
		
		<cfset var lastConfigDate = 0 />
		<cfset var configFile = "" />
		<cfset var shouldReload = true />
		
		<cfdirectory action="LIST" directory="#GetDirectoryFromPath(getConfigPath())#" 
			name="configFile" filter="#GetFileFromPath(getConfigPath())#" />
		
		<cfset lastConfigDate = ParseDateTime(configFile.dateLastModified) />
		<cfswitch expression="#DateCompare(getLastReloadDate(), lastConfigDate)#">
			<cfcase value="-1"><cfset shouldReload = true /></cfcase>
			<cfcase value="0"><cfset shouldReload = false /></cfcase>
			<cfcase value="1"><cfset shouldReload = false /></cfcase>
		</cfswitch>
		
		<cfreturn shouldReload />
	</cffunction>
	
	<cffunction name="reloadConfig" access="public" returntype="void">
		<cfset var appFactory = getAppFactory() />
		<cfset setAppManager(appFactory.createAppManager(getConfigPath())) />
		<cfset setLastReloadDate(Now()) />
	</cffunction>
	
	<cffunction name="setLastReloadDate" access="public" returntype="void" output="false">
		<cfargument name="lastReloadDate" type="date" required="true" />
		<cfset variables.lastReloadDate = arguments.lastReloadDate />
	</cffunction>
	<cffunction name="getLastReloadDate" access="public" returntype="date" output="false">
		<cfreturn variables.lastReloadDate />
	</cffunction>
	
	<cffunction name="setConfigPath" access="public" returntype="void" output="false">
		<cfargument name="configPath" type="string" required="true" />
		<cfset variables.configPath = arguments.configPath />
	</cffunction>
	<cffunction name="getConfigPath" access="public" returntype="string" output="false">
		<cfreturn variables.configPath />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
	<cffunction name="setAppFactory" access="public" returntype="void" output="false">
		<cfargument name="appFactory" type="cfcunit.machii.framework.AppFactory" required="true" />
		<cfset variables.appFactory = arguments.appFactory />
	</cffunction>
	<cffunction name="getAppFactory" access="public" returntype="cfcunit.machii.framework.AppFactory" output="false">
		<cfreturn variables.appFactory />
	</cffunction>

</cfcomponent>