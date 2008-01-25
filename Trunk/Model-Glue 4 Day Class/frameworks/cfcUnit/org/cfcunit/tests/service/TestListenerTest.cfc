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

<cfcomponent name="TestListenerTest" extends="org.cfcunit.framework.TestCase" output="false">
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
		<cfset var listener = newObject("org.cfcunit.service.TestListener").init(this)>
		
		<cfset variables.listener = listener>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testStartTest" returntype="void" access="public" output="false">
		<cfset var listener = variables.listener>
		<cfset var test = createObject("component", "TestListenerTest_Test").init("test", "test")>
		<cfset var currentTest = "">
		
		<cfset listener.startTest(test)>
		
		<cfset currentTest = listener.getCurrentTest()>
		
		<cfset assertEqualsString("test", currentTest.testName, "Test name does not match.")>
		<cfset assertEqualsString("test", currentTest.test, "String value of test does not match.")>
		<cfset assertTrue(isNumeric(currentTest.startTime), "Starttime should be a number.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	

	<cffunction name="testEndSuccessfulTest" returntype="void" access="public" output="false">
		<cfset var listener = variables.listener>
		<cfset var test = createObject("component", "TestListenerTest_Test").init("test", "test")>
		<cfset var currentTest = "">
		
		<cfset listener.startTest(test)>
		<cfset listener.endTest(test)>
		
		<cfset currentTest = listener.getCurrentTest()>
		
		<cfset assertTrue(isNumeric(currentTest.endTime), "End time should be a number")>
		<cfset assertEqualsNumber(abs(currentTest.endTime - currentTest.startTime), currentTest.executionTime)>
		<cfset assertFalse(currentTest.hasFailure, "Test should have been successful.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	

	<cffunction name="testAddError" returntype="void" access="public" output="false">
		<cfset var listener = variables.listener>
		<cfset var test = createObject("component", "TestListenerTest_Test").init("test", "test")>
		<cfset var errorArgs = structNew()>
		<cfset var error = "">
		<cfset var currentTest = "">
		<cfset var errors = "">

		<cfset errorArgs.className = "coldfusion.runtime.CustomException">
		<cfset errorArgs.message = "This is a test.">
		<cfset errorArgs.detail = "Yes, I mean it.">
		<cfset errorArgs.type = "Application">

		<cfset error = createObject("component", "ExceptionStub").init(argumentCollection=errorArgs)>
		
		<cfset listener.startTest(test)>
		<cfset listener.addError(test, error)>
		
		<cfset currentTest = listener.getCurrentTest()>
		
		<cfset assertTrue(currentTest.hasFailure, "Current test should have a failure.")>
		<cfset assertEqualsString("test", currentTest.failure.test)>
		<cfset assertEqualsString("test", currentTest.failure.testName)>
		<cfset assertSameComponent(error, currentTest.failure.exception)>
		<cfset assertEqualsString("Error", currentTest.failure.failureType)>
		
		<cfset errors = listener.getErrors()>
		<cfset assertTrue(arrayLen(errors) is 1)>
		<cfset assertSameStruct(currentTest.failure, errors[1])>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testAddFailure" returntype="void" access="public" output="false">
		<cfset var listener = variables.listener>
		<cfset var test = createObject("component", "TestListenerTest_Test").init("test", "test")>
		<cfset var failureArgs = structNew()>
		<cfset var failure = "">
		<cfset var currentTest = "">
		<cfset var failures = "">
		
		<cfset failureArgs.className = "coldfusion.runtime.CustomException">
		<cfset failureArgs.message = "This is a test.">
		<cfset failureArgs.detail = "Yes, I mean it.">
		<cfset failureArgs.type = "Application">
		
		<cfset failure = createObject("component", "ExceptionStub").init(argumentCollection=failureArgs)>

		<cfset listener.startTest(test)>
		<cfset listener.addFailure(test, failure)>
		
		<cfset currentTest = listener.getCurrentTest()>
		
		<cfset assertTrue(currentTest.hasFailure, "Current test should have a failure.")>
		<cfset assertEqualsString("test", currentTest.failure.test)>
		<cfset assertEqualsString("test", currentTest.failure.testName)>
		<cfset assertSameComponent(failure, currentTest.failure.exception)>
		<cfset assertEqualsString("Failure", currentTest.failure.failureType)>

		<cfset failures = listener.getFailures()>
		<cfset assertTrue(arrayLen(failures) is 1)>
		<cfset assertSameStruct(currentTest.failure, failures[1])>
	</cffunction>

	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="getErrorInfo" returntype="struct" access="public" output="false" hint="">
		<cfargument name="exception" type="any" required="true" hint=""/>
		
		<cfset var info = structNew()>
		
		<cfset info.exception = arguments.exception>
		
		<cfreturn info/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
</cfcomponent>