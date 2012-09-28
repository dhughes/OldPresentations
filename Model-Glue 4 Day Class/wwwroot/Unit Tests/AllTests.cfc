<cfcomponent>
	
	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfset var suite = CreateObject("component", "org.cfcunit.framework.TestSuite").init("Test Suite") />
		
		<!--- add tests --->
		<cfset suite.addTestSuite(CreateObject("component", "Unit Tests.TestFortune"))>
		
		<!--- add other suites
		<cfset suite.addTest(CreateObject("component", "Unit Tests.Example.AllTests").suite())>
		--->
		
		<cfreturn suite/>
	</cffunction>

</cfcomponent>