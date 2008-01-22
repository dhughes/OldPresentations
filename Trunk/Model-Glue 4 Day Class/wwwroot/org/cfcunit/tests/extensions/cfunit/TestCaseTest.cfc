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

<!---
$Id: TestCaseTest.cfc,v 1.2 2006/11/21 20:49:40 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/tests/extensions/cfunit/TestCaseTest.cfc,v $
--->

<cfcomponent name="TestCaseTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!---------------------------------------------------------------------------->
	
	<cffunction name="testGetName" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestCase = CreateObject("component", "TestCaseTest$CFUnitTestCase").init("testDoNothing")>
		<cfset var testCase = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTestCase)>

		<cfset assertEqualsString(cfUnitTestCase.getName(), testCase.getName())>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testSetName" returntype="void" access="public" output="false" 
		hint="This tests to make sure that the wrapper object sets the name of its CFUnit TestCase object.">
		
		<cfset var cfUnitTestCase = CreateObject("component", "TestCaseTest$CFUnitTestCase").init()>
		<cfset var testCase = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTestCase)>
		
		<cfset testCase.setName("testNothing")>

		<cfset assertEqualsString("testNothing", cfUnitTestCase.getName())>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testToStringValue" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestCase = CreateObject("component", "TestCaseTest$CFUnitTestCase").init("testDoNothing")>
		<cfset var testCase = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTestCase)>
		<cfset var expected = "testDoNothing(org.cfcunit.tests.extensions.cfunit.TestCaseTest$CFUnitTestCase)">
		<cfset var actual = testCase.toStringValue()>
		
		<cfset assertEqualsString(expected, actual)>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testCountTestCases" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestCase = CreateObject("component", "TestCaseTest$CFUnitTestCase").init("testDoNothing")>
		<cfset var testCase = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTestCase)>

		<cfset assertEqualsNumber(cfUnitTestCase.countTestCases(), testCase.countTestCases())>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testRunWithTestResults" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestCase = CreateObject("component", "TestCaseTest$CFUnitTestCase").init("testDoNothing")>
		<cfset var testCase = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTestCase)>
		<cfset var testResult = newObject("org.cfcunit.framework.TestResult").init()>

		<cfset testCase.run(testResult)>
		
		<cfset assertEqualsNumber(1, testResult.runCount(), "runCount() should return 1.")>
		<cfset assertEqualsNumber(0, testResult.failureCount(), "failureCount() should return 0.")>
		<cfset assertEqualsNumber(0, testResult.errorCount(), "errorCount() should return 0.")>
		<cfset assertTrue(testResult.wasSuccessful(), "wasSuccessful() should return TRUE.")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

</cfcomponent>