<cfcomponent>
	
	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfset var suite = CreateObject("component", "org.cfcunit.framework.TestSuite").init("Test Suite") />
		
		<!--- add tests --->
		<cfset suite.addTestSuite(CreateObject("component", "TestCategoryGateway"))>
		<cfset suite.addTestSuite(CreateObject("component", "TestDatasource"))>
		<cfset suite.addTestSuite(CreateObject("component", "TestFortune"))>
		<cfset suite.addTestSuite(CreateObject("component", "TestFortuneBean"))>
		<cfset suite.addTestSuite(CreateObject("component", "TestFortuneDao"))>
		
		<!--- add other suites
		<cfset suite.addTest(CreateObject("component", "Unit Tests.Example.AllTests").suite())>
		--->
		
		<cfreturn suite/>
	</cffunction>

</cfcomponent>