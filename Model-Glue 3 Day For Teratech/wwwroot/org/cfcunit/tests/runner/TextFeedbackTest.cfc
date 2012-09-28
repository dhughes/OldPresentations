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

<cfcomponent displayname="TextFeedbackTest" extends="org.cfcunit.framework.TestCase" output="false" hint="">
	
	<!----------------------------------------------------------->
	
	<cfproperty name="output" type="string" hint=""/>
	<cfproperty name="runner" type="org.cfcunit.textui.TestRunner" hint=""/>
		
	<cfset variables.fPrinter = NULL>
	<cfset variables.fRunner = NULL>
	
	<!----------------------------------------------------------->

	<cffunction name="init" returntype="TextFeedbackTest" access="public" output="false">
		<cfset super.init()>
		
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="execute" returntype="void" access="public" output="false">
		<cfset var testRunner = newObject("org.cfcunit.textui.TestRunner")>
		
		<cfset testRunner.run(test=newObject("org.cfcunit.tests.runner.TextFeedbackTest"))>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="expected" returntype="string" access="private" output="false">
		<cfargument name="lines" type="array" required="true"/>
		<!--- --->
		<cfset var i = 0>
		<cfset var newLine = Chr(13) & Chr(10)>
		<cfset var expected = NULL>
		
		<cfloop index="i" from="1" to="#ArrayLen(arguments.lines)#">
			<cfset expected = expected & arguments.lines[i] & newLine>
		</cfloop>
		
		<cfreturn expected/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="public" output="false" 
		hint="Sets up the fixture, for example, open a network connection.">
		
		<cfset variables.fPrinter = newTestResultPrinter().init()>
		<cfset variables.fRunner = newObject("org.cfcunit.textui.TestRunner").init(variables.fPrinter)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testEmptySuite" returntype="void" access="public" output="false">
		<cfset var lines = ArrayNew(1)>
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>

		<cfset lines[1] = "">
		<cfset lines[2] = "Time: 0 seconds">
		<cfset lines[3] = "">
		<cfset lines[4] = "OK (0 tests)">
	
		<cfset variables.fRunner.doRun(testSuite)>
		
		<cfset assertEqualsString(expected(lines), variables.fPrinter.getContent())>
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="testError" returntype="void" access="public" output="false">
		<cfset var lines = ArrayNew(1)>
		<cfset var printer = newTestResultPrinter("testError")>
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		<cfset var testCase = newTestCase("testError")>
		
		<cfset lines[1] = ".E">
		<cfset lines[2] = "Time: 0 seconds">
		<cfset lines[3] = "Errors here">
		<cfset lines[4] = "">
		<cfset lines[5] = "FAILURES!!!">
		<cfset lines[6] = "Tests run: 1,  Failures: 0,  Errors: 1">
				
		<cfset variables.fRunner.setPrinter(printer)>
		<cfset testSuite.addTest(testCase)>
		<cfset variables.fRunner.doRun(testSuite)>
		
		<cfset assertEqualsString(expected(lines), printer.getContent())>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testFailure" returntype="void" access="public" output="false">
		<cfset var lines = ArrayNew(1)>
		<cfset var printer = newTestResultPrinter("testFailure")>
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		<cfset var testCase = newTestCase("testFailure")>

		<cfset lines[1] = ".F">
		<cfset lines[2] = "Time: 0 seconds">
		<cfset lines[3] = "Failures here">
		<cfset lines[4] = "">
		<cfset lines[5] = "FAILURES!!!">
		<cfset lines[6] = "Tests run: 1,  Failures: 1,  Errors: 0">
		
		<cfset variables.fRunner.setPrinter(printer)>
		<cfset testSuite.addTest(testCase)>
		<cfset variables.fRunner.doRun(testSuite)>
		
		<cfset assertEqualsString(expected(lines), printer.getContent())>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testOneTest" returntype="void" access="public" output="false">
		<cfset var lines = ArrayNew(1)>
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		<cfset var testCase = newTestCase("testOneTest")>
		
		<cfset lines[1] = ".">
		<cfset lines[2] = "Time: 0 seconds">
		<cfset lines[3] = "">
		<cfset lines[4] = "OK (1 test)">
		
		<cfset testSuite.addTest(testCase)>
		<cfset variables.fRunner.doRun(testSuite)>
		
		<cfset assertEqualsString(expected(lines), variables.fPrinter.getContent())>
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="testTwoTests" returntype="void" access="public" output="false">
		<cfset var lines = ArrayNew(1)>
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite")>
		<cfset var testCase1 = newTestCase("testTwoTests1")>
		<cfset var testCase2 = newTestCase("testTwoTests2")>
		
		<cfset lines[1] = "..">
		<cfset lines[2] = "Time: 0 seconds">
		<cfset lines[3] = "">
		<cfset lines[4] = "OK (2 tests)">
		
		<cfset testSuite.addTest(testCase1)>
		<cfset testSuite.addTest(testCase2)>
		<cfset variables.fRunner.doRun(testSuite)>
		
		<cfset assertEqualsString(expected(lines), variables.fPrinter.getContent())>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="newTestCase" returntype="org.cfcunit.framework.TestCase" access="private" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var prefix = "org.cfcunit.tests.runner.TextFeedbackTest.$">
		<cfset var suffix = "$TestCase">
		<cfset var fullName = prefix & arguments.name & suffix>
		
		<cfif NOT Len(arguments.name)>
			<cfset fullName = "org.cfcunit.framework.TestCase">
		</cfif>
		
		<cftry>
			<cfreturn newObject(fullName)/>
			
			<cfcatch type="any">
				<cfreturn newObject("org.cfcunit.framework.TestCase")/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="newTestResultPrinter" returntype="org.cfcunit.tests.runner.TextFeedbackTest.$TestResultPrinter" access="private" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var prefix = "org.cfcunit.tests.runner.TextFeedbackTest.$">
		<cfset var suffix = "$TestResultPrinter">
		<cfset var fullName = prefix & arguments.name & suffix>
		
		<cfif NOT Len(arguments.name)>
			<cfset fullName = prefix & "TestResultPrinter">
		</cfif>
		
		<cftry>
			<cfreturn newObject(fullName)/>
			
			<cfcatch type="any">
				<cfset fullName = prefix & "TestResultPrinter">
				<cfreturn newObject(fullName)/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>