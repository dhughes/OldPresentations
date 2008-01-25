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

<cfcomponent displayname="TextRunnerTest" extends="org.cfcunit.framework.TestCase" output="false" hint="">
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TextRunnerTest" access="public" output="false">
		<cfset super.init()>
		
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="execTest" returntype="void" access="private" output="false" throws="Exception">
		<cfargument name="testClass" type="string" required="true"/>
		<cfargument name="success" type="boolean" required="true"/>
		<!--- --->
		<cfset var printer = newObject("org.cfcunit.textui.ResultPrinter").init()>
		<cfset var runner = newObject("org.cfcunit.textui.TestRunner").init(printer)>
		<cfset var exitCode = -1>
		
		<cfset exitCode = runner.execute(arguments.testClass)>
		
		<cfset assertTrue((exitCode IS 0) IS arguments.success, "exitCode: #exitCode#")>
		
		<cfif arguments.success>
			<cfset assertEqualsNumber(runner.SUCCESS_EXIT, exitCode, "SUCCESS_EXIT NEQ #exitcode#")>
		<cfelse>
			<cfset assertEqualsNumber(runner.FAILURE_EXIT, exitCode, "FAILURE_EXIT NEQ #exitcode#")>
		</cfif>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="testError" returntype="void" access="public" output="false" throws="Exception">
		<cfset execTest("org.cfcunit.tests.BogusDude", false)>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="testFailure" returntype="void" access="public" output="false" throws="Exception">
		<cfset execTest("org.cfcunit.tests.framework.Failure", false)>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="testRunReturnsResult" returntype="void" access="public" output="false" throws="Exception">
		<cfset var printer = newObject("org.cfcunit.textui.ResultPrinter").init()>
		<cfset var runner = newObject("org.cfcunit.textui.TestRunner").init()>
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init()>
		<cfset var result = NULL>
		
		<cfset result = runner.run(test=testSuite)>
		<cfset assertTrue(result.wasSuccessful())>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="testSuccess" returntype="void" access="public" output="false" throws="Exception">
		<cfset execTest("org.cfcunit.tests.framework.Success", true)>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
</cfcomponent>