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

<cfcomponent displayname="SuiteTest" extends="org.cfcunit.framework.TestCase" output="false"
	hint="A fixture for testing the 'auto' test suite feature.">

	<!-------------------------------------------------------------------->
	
	<cfproperty name="fResult" type="org.cfcunit.framework.TestResult" hint=""/>
	
	<cfset variables.fResult = NULL>
	
	<!-------------------------------------------------------------------->

	<cffunction name="init" returntype="SuiteTest" access="public" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		
		<cfset super.init(arguments.name)>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="private" output="false" 
		hint="Sets up the fixture, for example, open a network connection. This method is called before a test is executed.">
		
		<cfset variables.fResult = newObject("org.cfcunit.framework.TestResult").init()>		
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init("Suite Tests")>
		
		<!--- build the suite manually, because some of the suites are testing
			the functionality that automatically builds suites --->
			

		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testNoTestCaseClass"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testNoTestCases"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testOneTestCase"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testNotPublicTestCase"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testNotVoidTestCase"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testNotExistingTestCase"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testInheritedTests"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testShadowedTests"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.framework.SuiteTest").init("testAddTestSuite"))>
		
		<cfreturn testSuite/>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testAddTestSuite" returntype="void" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.framework.OneTestCase"))>

		<cfset testSuite.run(variables.fResult)>

		<cfset assertEqualsNumber(1, variables.fResult.runCount())>
	</cffunction>
	
	<!-------------------------------------------------------------------->

	<cffunction name="testInheritedTests" returntype="void" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset testSuite.init(testClass=newObject("org.cfcunit.tests.framework.InheritedTestCase"))>
		<cfset testSuite.run(variables.fResult)>
		
		<cfset assertTrue(variables.fResult.wasSuccessful())>
		<cfset assertEqualsNumber(2, variables.fResult.runCount())>
	</cffunction>
	
	<!-------------------------------------------------------------------->

	<cffunction name="testNoTestCaseClass" returntype="void" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset testSuite.init(testClass=newObject("org.cfcunit.tests.framework.NoTestCaseClass"))>
		<cfset testSuite.run(variables.fResult)>
		
		<cfset assertEqualsNumber(1, variables.fResult.runCount())> <!--- warning test --->
		<cfset assertTrue(NOT variables.fResult.wasSuccessful())>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testNoTestCases" returntype="void" access="public" output="false">
		<cfset var test = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset test.init(testClass=newObject("org.cfcunit.tests.framework.NoTestCases"))>
		<cfset test.run(variables.fResult)>
		
		<cfset assertTrue(variables.fResult.runCount() IS 1)> <!--- warning test --->
		<cfset assertTrue(variables.fResult.failureCount() IS 1)>
		<cfset assertTrue(NOT variables.fResult.wasSuccessful())>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testNotExistingTestCase" returntype="void" access="public" output="false">
		<cfset var test = newObject("org.cfcunit.tests.framework.SuiteTest").init("notExistingMethod")>
		
		<cfset test.run(variables.fResult)>
		
		<cfset assertTrue(variables.fResult.runCount() IS 1)>
		<cfset assertTrue(variables.fResult.failureCount() IS 1)>
		<cfset assertTrue(variables.fResult.errorCount() IS 0)>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testNotPublicTestCase" returntype="void" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset testSuite.init(testClass=newObject("org.cfcunit.tests.framework.NotPublicTestCase"))>
		
		<!--- 1 public test case + 1 warning for the non-public test case --->
		<cfset assertEqualsNumber(2, testSuite.countTestCases())>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testNotVoidTestCase" returntype="void" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset testSuite.init(testClass=newObject("org.cfcunit.tests.framework.NotVoidTestCase"))>
		<cfset assertTrue(testSuite.countTestCases() IS 1)>
	</cffunction>
	
	<!-------------------------------------------------------------------->

	<cffunction name="testOneTestCase" returntype="void" access="public" output="false">
		<cfset var test = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset test.init(testClass=newObject("org.cfcunit.tests.framework.OneTestCase"))>
		<cfset test.run(variables.fResult)>
		
		<cfset assertTrue(variables.fResult.runCount() IS 1)>
		<cfset assertTrue(variables.fResult.failureCount() IS 0)>
		<cfset assertTrue(variables.fResult.errorCount() IS 0)>
		<cfset assertTrue(variables.fResult.wasSuccessful())>
	</cffunction>
	
	<!-------------------------------------------------------------------->

	<cffunction name="testShadowedTests" returntype="void" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset testSuite.init(testClass=newObject("org.cfcunit.tests.framework.OverrideTestCase"))>
		
		<cfset testSuite.run(variables.fResult)>
		<cfset assertEqualsNumber(1, variables.fResult.runCount())>
	</cffunction>
	
	<!-------------------------------------------------------------------->

</cfcomponent>