
<cfcomponent 
	displayname="AppFactory" 
	output="false"
	hint="Factory class for creating instances of AppManager.">
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">	
	</cffunction> 
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="createAppManager" returntype="cfcunit.machii.framework.AppManager">
		<cfargument name="configXmlPath" type="string" required="true" />
		
		<cfset var appManager = 0 />
		<cfset var propertyManager = 0 />
		<cfset var listenerManager = 0 />
		<cfset var filterManager = 0 />
		<cfset var eventManager = 0 />
		<cfset var viewManager = 0 />
		<cfset var pluginManager = 0 />
		<cfset var configXML = "" />
		<cfset var configXmlFile = "" />
		
		<!--- Parse the appManager.xml file. --->
		<cffile 
			action="READ" 
			file="#arguments.configXmlPath#" 
			variable="configXmlFile" />
		<cfset configXML = XmlParse(configXmlFile) />
		
		<!--- Create the AppManager. --->
		<cfset appManager = CreateObject('component', 'cfcunit.machii.framework.AppManager') />
		<cfset appManager.init(configXML) />
		
		<!--- 
			Create the Framework Managers and set them in the AppManager. 
			Creation order is important: propertyManager first, listenerManager and filterManager before eventManager. 
		--->
		<cfset propertyManager = CreateObject('component', 'cfcunit.machii.framework.PropertyManager') />
		<cfset propertyManager.init(configXML, appManager) />
		<cfset appManager.setPropertyManager(propertyManager) />
		
		<cfset listenerManager = CreateObject('component', 'cfcunit.machii.framework.ListenerManager') />
		<cfset listenerManager.init(configXML, appManager) />
		<cfset appManager.setListenerManager(listenerManager) />
		
		<cfset filterManager = CreateObject('component', 'cfcunit.machii.framework.FilterManager') />
		<cfset filterManager.init(configXML, appManager) />
		<cfset appManager.setFilterManager(filterManager) />
		
		<cfset eventManager = CreateObject('component', 'cfcunit.machii.framework.EventManager') />
		<cfset eventManager.init(configXML, appManager) />
		<cfset appManager.setEventManager(eventManager) />
		
		<cfset viewManager = CreateObject('component', 'cfcunit.machii.framework.ViewManager') />
		<cfset viewManager.init(configXML, appManager) />
		<cfset appManager.setViewManager(viewManager) />
		
		<cfset pluginManager = CreateObject('component', 'cfcunit.machii.framework.PluginManager') />
		<cfset pluginManager.init(configXML, appManager) />
		<cfset appManager.setPluginManager(pluginManager) />
		
		<cfset appManager.configure() />
		
		<cfreturn appManager />
	</cffunction>
	
</cfcomponent>