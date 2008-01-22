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
$Id: TestSuiteTest.cfc,v 1.2 2006/11/21 20:49:40 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/tests/extensions/cfunit/TestSuiteTest.cfc,v $
--->

<cfcomponent name="TestSuiteTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------->
	
	<cffunction name="testConstructorWithName" returntype="void" access="public" output="false" hint="">
		<cfset var suiteName = "Test Suite Name">
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init(name=suiteName)>
		
		<cfset assertEqualsString(suiteName, testSuite.getName())>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testConstructorWithClasses" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestClassName = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$CFUnitTestCase">
		<cfset var cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init(classes=cfUnitTestClassName)>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init(testClass=cfUnitTestSuite)>
		
		<cfset assertEqualsNumber(1, testSuite.countTestCases())>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testCountTestCases" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestClassName1 = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$CFUnitTestCase">
		<cfset var cfUnitTestClassName2 = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$SingleTestCase">
		<cfset var classNames = ListToArray("#cfUnitTestClassName1#,#cfUnitTestClassName2#", ",")>
		<cfset var cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init(classes=classNames)>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init(testClass=cfUnitTestSuite)>
		
		<cfset assertEqualsNumber(cfUnitTestSuite.countTestCases(), testSuite.countTestCases())>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testAddTestSuiteWithOneTest" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestClass = CreateObject("component", "TestSuiteTest$SingleTestCase")>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init("Test Suite")>
		<cfset var cfUnitTestSuite = NULL>
		
		<cfset testSuite.addTestSuite(cfUnitTestClass)>
		
		<cfset cfUnitTestSuite = testSuite.getTestSuite()>
		
		<cfset assertEqualsNumber(1, testSuite.countTestCases())>
		<cfset assertEqualsNumber(testSuite.countTestCases(), cfUnitTestSuite.countTestCases())>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testAddTestSuiteForMultipleClasses" returntype="void" access="public" output="false" hint="">
		<cfset var cfUnitTestClass1 = CreateObject("component", "TestSuiteTest$SingleTestCase")>
		<cfset var cfUnitTestClass2 = CreateObject("component", "TestSuiteTest$CFUnitTestCase")>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init("Test Suite")>
		<cfset var cfUnitTestSuite = NULL>
		
		<cfset testSuite.addTestSuite(cfUnitTestClass1)>
		<cfset testSuite.addTestSuite(cfUnitTestClass2)>
		
		<cfset cfUnitTestSuite = testSuite.getTestSuite()>
		
		<cfset assertEqualsNumber(2, testSuite.countTestCases())>
		<cfset assertEqualsNumber(testSuite.countTestCases(), cfUnitTestSuite.countTestCases())>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testRunWithSuccessfulTest" returntype="void" access="public" output="false" hint="">
		<cfset var testClassName = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$SuccessfulTests">
		<cfset var cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init(testClassName)>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init("Successful Tests", cfUnitTestSuite)>
		<cfset var testResult = newObject("org.cfcunit.framework.TestResult").init()>
		
		<cfset testSuite.run(testResult)>
		
		<cfset assertTrue(testResult.wasSuccessful())>
		<cfset assertEqualsNumber(1, testResult.runCount(), "There should be one test run.")>
		<cfset assertEqualsNumber(0, testResult.failureCount(), "There should be zero failures.")>
		<cfset assertEqualsNumber(0, testResult.errorCount(), "There should be zero errors.")>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testRunWithFailureTest" returntype="void" access="public" output="false" hint="">
		<cfset var testClassName = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$FailureTests">
		<cfset var cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init(testClassName)>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init("Failure Tests", cfUnitTestSuite)>
		<cfset var testResult = newObject("org.cfcunit.framework.TestResult").init()>
		
		<cfset testSuite.run(testResult)>
		
		<cfset assertFalse(testResult.wasSuccessful())>
		<cfset assertEqualsNumber(1, testResult.runCount(), "There should be one test run.")>
		<cfset assertEqualsNumber(1, testResult.failureCount(), "There should be one failure.")>
		<cfset assertEqualsNumber(0, testResult.errorCount(), "There should be zero errors.")>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testRunWithErrorTest" returntype="void" access="public" output="false" hint="">
		<cfset var testClassName = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$ErrorTests">
		<cfset var cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init(testClassName)>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init("Error Tests", cfUnitTestSuite)>
		<cfset var testResult = newObject("org.cfcunit.framework.TestResult").init()>
		
		<cfset testSuite.run(testResult)>
		
		<cfset assertFalse(testResult.wasSuccessful())>
		<cfset assertEqualsNumber(1, testResult.runCount(), "There should be one test run.")>
		<cfset assertEqualsNumber(0, testResult.failureCount(), "There should be zero failures.")>
		<cfset assertEqualsNumber(1, testResult.errorCount(), "There should be one error.")>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="testTestAtReturnsTestCase" returntype="void" access="public" output="false" hint="">
		<cfset var testClassName = "org.cfcunit.tests.extensions.cfunit.TestSuiteTest$MultiTestCase">
		<cfset var cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init(testClassName)>
		<cfset var testSuite = newObject("org.cfcunit.extensions.cfunit.TestSuite").init("Tests", cfUnitTestSuite)>
		<cfset var tests = testSuite.tests()>
		
		<cfset assertEqualsNumber(3, testSuite.countTestCases())>
		
		<cfset assertEqualsString(tests[1].toStringValue(), testSuite.testAt(1).toStringValue())>
		<cfset assertEqualsString(tests[2].toStringValue(), testSuite.testAt(2).toStringValue())>
		<cfset assertEqualsString(tests[3].toStringValue(), testSuite.testAt(3).toStringValue())>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
</cfcomponent>