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

<cfcomponent displayname="TestRunner" extends="org.cfcunit.runner.BaseTestRunner" output="true"
	hint="
			<p>
				TestRunner.execute() expects the name of a TestCase class as argument. If this class defines a 
				<i>suite</i> method it will be invoked and the returned test is run. Otherwise all 
				the methods starting with 'test' having no arguments are run.
			</p> 
			<p>
				TestRunner prints a trace as the tests are executed followed by a summary at the end.
			</p>
		">
		
	<!----------------------------------------------------------->
	
	<cfproperty name="SUCCESS_EXIT" type="numeric" default="0" hint="Constaint Field Value"/>
	<cfproperty name="FAILURE_EXIT" type="numeric" default="1" hint="Constant Field Value"/>
	<cfproperty name="EXCEPTION_EXIT" type="numeric" default="2" hint="Constant Field Value"/>

	<cfproperty name="printer" type="org.cfcunit.textui.ResultPrinter" hint=""/>
	
	<!----------------------------------------------------------->
	
	<cfset this.SUCCESS_EXIT = 0>
	<cfset this.FAILURE_EXIT = 1>
	<cfset this.EXCEPTION_EXIT = 2>
	
	<cfset variables["SUCCESS_EXIT"] = 0>
	<cfset variables["FAILURE_EXIT"] = 1>
	<cfset variables["EXCEPTION_EXIT"] = 2>
		
	<cfset variables["printer"] = NULL>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestRunner" access="public" output="false" hint="Constructs a TestRunner.">
		<cfargument name="printer" type="org.cfcunit.textui.ResultPrinter" required="false"/>
		
		<cfif StructKeyExists(arguments, "printer")>
			<cfset variables.printer = arguments.printer.init(this)>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
			
	<!----------------------------------------------------------->
	
	<cffunction name="createTestResult" returntype="org.cfcunit.framework.TestResult" access="private" output="false" 
		hint="Creates the TestResult to be used for the test run.">
		
		<cfreturn newObject("org.cfcunit.framework.TestResult").init()/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="doRun" returntype="org.cfcunit.framework.TestResult" access="public" output="false">
		<cfargument name="suite" type="org.cfcunit.framework.Test" required="true"/>
		<!--- --->
		<cfset var result = createTestResult()>
		<cfset var startTime = 0>
		<cfset var endTime = 0>
		<cfset var runTime = 0>
		
		<cfif IsObject(variables.printer)>
			<cfset result.addListener(variables.printer)>
		</cfif>

		<cfset startTime = GetTickCount()>
		<cfset arguments.suite.run(result)>
		<cfset endTime = GetTickCount()>
		<cfset runTime = Abs(endTime - startTime)>
		
		<cfif IsObject(variables.printer)>
			<cfset variables.printer.print(result, runTime)>
		</cfif>
		
		<cfreturn result/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="execute" returntype="numeric" access="public" output="true" hint="This is the main entry point into this class.">
		<cfargument name="testCaseClass" type="string" required="true"/>
		<!--- --->
		<cfset var result = NULL>
		
		<cftry>
			<cfset result = start(arguments.testCaseClass)>
			<cfif NOT result.wasSuccessful()>
				<cfreturn this.FAILURE_EXIT/>
			</cfif>
			<cfreturn this.SUCCESS_EXIT/>
			
			<cfcatch type="System.Exit">
				<cfset WriteOutput(cfcatch.Message)>
				<cfreturn cfcatch.ErrorCode/>
			</cfcatch>
			
			<cfcatch type="any">
				<cfthrow type="Exception" 
					message="#getFilteredTraceFromString(cfcatch.stacktrace)#"/>
				
				<!---
				<cfset WriteOutput(cfcatch.Message)>
				<cfreturn this.EXCEPTION_EXIT/>
				--->
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="run" returntype="org.cfcunit.framework.TestResult" access="public" output="false" hint="">
		<cfargument name="className" type="string" required="false"/>
		<cfargument name="test" type="WEB-INF.cftags.component" required="false"/>
		
		<cfif StructKeyExists(arguments, "className")>
			<cfreturn runWithClassName(arguments.className)/>
		<cfelseif StructKeyExists(arguments, "test")>
			<cfreturn runWithObject(arguments.test)/>
		</cfif>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runWithClassName" returntype="org.cfcunit.framework.TestResult" access="private" output="false" hint="Runs a suite extracted from a TestCase subclass.">
		<cfargument name="testClassName" type="string" required="true"/>
		<!--- --->
		<cfset var test = newObject(arguments.testClassName)>
		<cfset var suite = newObject("org.cfcunit.framework.TestSuite")>
		
		<cfset suite.init(testClass=test)>
		
		<cfreturn runWithObject(suite)/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runWithObject" returntype="org.cfcunit.framework.TestResult" access="private" output="false" hint="Runs a single test and collects its results.">
		<cfargument name="test" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		<cfset var runner = newObject("org.cfcunit.textui.TestRunner")>
		
		<cfreturn runner.doRun(arguments.test)/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="setPrinter" returntype="void" access="public" output="false">
		<cfargument name="printer" type="org.cfcunit.textui.ResultPrinter" required="true"/>
		
		<cfset variables.printer = arguments.printer>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="start" returntype="org.cfcunit.framework.TestResult" access="private" output="true" throws="Exception" 
		hint="Starts a test run. Analyzes the arguments and runs the given test suite.">
		
		<cfargument name="testCase" type="string" required="true"/>
		<!--- --->
		<cfset var suite = NULL>
		
		<cfif NOT Len(arguments.testCase)>
			<cfthrow type="Exception" message="You must specify the name of a TestCase class."/>
		</cfif>
		
		<cftry>
			<cfset suite = getTest(arguments.testCase)>
			
			<cfreturn doRun(suite)/>
			
			<cfcatch type="Exception">
				<cfthrow type="Exception" message="Could not create and run test suite: #cfcatch.Message#"/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runFailed" returntype="void" access="private" output="false">
		<cfargument name="message" type="string" required="true"/>
		
		<cfthrow type="System.Exit" message="#arguments.message#" errorcode="#this.FAILURE_EXIT#"/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getLoader" returntype="org.cfcunit.runner.TestSuiteLoader" access="public" output="false" 
		hint="Always use the StandardTestSuiteLoader. Overridden from BaseTestRunner.">
		
		<!--- This does nothing. --->
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="testStarted" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
		
		<!--- This does nothing. --->
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testEnded" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
		
		<!--- This does nothing. --->
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testFailed" returntype="void" access="public" output="false">
		<cfargument name="status" type="numeric" required="true"/>
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<!--- This does nothing. --->
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>