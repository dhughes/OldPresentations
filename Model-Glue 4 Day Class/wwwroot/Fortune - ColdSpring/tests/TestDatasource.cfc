<cfcomponent extends="org.cfcunit.framework.TestCase" output="false" >

	<!--- setup the test --->
	<cffunction name="setup" returntype="void" access="private"> 
		<cfsetting showdebugoutput="false" />
		
		<cfset dsn = "Fortune" />
		<cfset username = "test1" />
		<cfset password = "test2" />

		<cfset Datasource = CreateObject("Component", "Fortune - ColdSpring.model.Datasource").init(dsn, username, password) />
	</cffunction>
	
	<!--- test getDatasource --->
	<cffunction name="testGetDatasource" access="public" returntype="void">
		<!--- the datasource should be as inited --->
		<cfset assertEqualsString(Datasource.getDatasource(), dsn, "getDatasource does not return correct value.") />
	</cffunction>
	
	<!--- test getUsername --->
	<cffunction name="testGetUsername" access="public" returntype="void">
		<!--- the username should be as inited --->
		<cfset assertEqualsString(Datasource.getUsername(), username, "getUsername does not return correct value.") />
	</cffunction>	
	
	<!--- test getPassword --->
	<cffunction name="testGetPassword" access="public" returntype="void">
		<!--- the password should be as inited --->
		<cfset assertEqualsString(Datasource.getPassword(), password, "getPassword does not return correct value.") />
	</cffunction>
	
</cfcomponent>