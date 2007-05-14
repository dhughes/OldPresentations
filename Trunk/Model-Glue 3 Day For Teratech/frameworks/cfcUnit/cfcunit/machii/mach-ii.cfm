
<!--- Set the path to the application's mach-ii.xml file. --->
<cfparam name="MACHII_CONFIG_PATH" type="string" default="#ExpandPath('./config/mach-ii.xml')#" />

<!--- Set the configuration mode (when to reload): -1=never, 0=dynamic, 1=always --->
<!--- default is request.MachIIConfigMode if it is defined, else use cfparam --->
<cfif NOT IsDefined("MACHII_CONFIG_MODE")>
	<cfif StructKeyExists(request,"MachIIConfigMode")>
		<cfset MACHII_CONFIG_MODE = request.MachIIConfigMode />
	</cfif>
</cfif>
<cfparam name="MACHII_CONFIG_MODE" type="numeric" default="0" />

<!--- Set the app key for sub-applications within a single cf-application. --->
<cfparam name="MACHII_APP_KEY" type="string" default="#GetFileFromPath(ExpandPath('.'))#" />

<cfif NOT StructKeyExists(application,MACHII_APP_KEY)>
	<cflock name="application_#MACHII_APP_KEY#" type="exclusive" timeout="120">
		<cfif NOT StructKeyExists(application,MACHII_APP_KEY)>
			<cfset application[MACHII_APP_KEY] = StructNew() />
		</cfif>
	</cflock>
</cfif>

<!--- Create the AppLoader if necessary. --->
<cfif NOT (StructKeyExists(application[MACHII_APP_KEY],'appLoader') 
		AND IsObject(application[MACHII_APP_KEY].appLoader))>
	<cflock name="application_#MACHII_APP_KEY#_apploader" type="exclusive" timeout="120">
		<cfif NOT (StructKeyExists(application[MACHII_APP_KEY],'appLoader') 
				AND IsObject(application[MACHII_APP_KEY].appLoader))>
			<cfset application[MACHII_APP_KEY].appLoader = CreateObject('component', 'cfcunit.machii.framework.AppLoader').init(MACHII_CONFIG_PATH) />
		</cfif>
	</cflock>
</cfif>

<!--- Reload the configuration if necessary. --->
<cfif MACHII_CONFIG_MODE EQ 1>
	<cflock name="application_#MACHII_APP_KEY#_reload" type="exclusive" timeout="120">
		<cfset application[MACHII_APP_KEY].appLoader.reloadConfig() />
	</cflock>
<cfelseif MACHII_CONFIG_MODE EQ 0 AND application[MACHII_APP_KEY].appLoader.shouldReloadConfig()>
	<cflock name="application_#MACHII_APP_KEY#_reload" type="exclusive" timeout="120">
		<cfset application[MACHII_APP_KEY].appLoader.reloadConfig() />
	</cflock>
<cfelseif MACHII_CONFIG_MODE EQ -1>
	<!--- Do not reload config. --->
</cfif>

<!--- Handle the Request. --->
<cfset application[MACHII_APP_KEY].appLoader.getAppManager().getRequestHandler().handleRequest() />