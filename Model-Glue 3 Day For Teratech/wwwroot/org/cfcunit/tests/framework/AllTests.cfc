<!---
   Copyright (c) 2006, Paul Kenney
   All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--->

<cfcomponent displayname="AllTests" extends="org.cfcunit.Object" output="false" hint="TestSuite that runs all the sample tests.">

	<cfset variables.content = NULL>
	<cfset variables.printer = NULL>
	<cfset variables.runner = NULL>

	<!----------------------------------------------------------------------------------->
	
	<!---
	<cffunction name="execute" returntype="void" access="public" output="false">
		<cfset variables.content = NULL>
		<cfset variables.printer = newObject("org.cfcunit.textui.ResultPrinter")>
		<cfset variables.runner = newObject("org.cfcunit.textui.TestRunner")>
		
		<cfset variables.runner.init(variables.printer)>
		
		<cfset variables.runner.run(test=this)>
		
		<cfset variables.content = variables.printer.getContent()>		
	</cffunction>
	--->
	
	<!----------------------------------------------------------------------------------->

	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init("Framework Tests")>
		
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.TestCaseTest"))>
		
		<!--- Tests suite building, so can't use automatic test extraction --->
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").suite())>
		
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.TestListenerTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.AssertTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.TestImplementorTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.NoArgTestCaseTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.ComparisonFailureTest"))>
		
		<!--- Test class does not exist. 
			<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.DoublePrecisionAssertTest"))> --->
		
		<cfreturn testSuite/>
	</cffunction>
	
	<!----------------------------------------------------------------------------------->
	
	<cffunction name="getContent" returntype="string" access="public" output="false">
		<cfreturn variables.content/>
	</cffunction>
	
	<!----------------------------------------------------------------------------------->
	
</cfcomponent>