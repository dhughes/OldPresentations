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

<cfcomponent name="TestRunner" extends="org.cfcunit.runner.BaseTestRunner" output="true"
	hint="
			<p>
				TestRunner.execute() expects the name of a TestCase class as argument. If this class defines a 
				<i>suite</i> method it will be invoked and the returned test is run. Otherwise all 
				the methods starting with 'test' having no arguments are run.
			</p>
		">
		
	<!----------------------------------------------------------->
	
	<cfproperty name="SUCCESS_EXIT" type="numeric" default="0" hint="Constaint Field Value"/>
	<cfproperty name="FAILURE_EXIT" type="numeric" default="1" hint="Constant Field Value"/>
	<cfproperty name="EXCEPTION_EXIT" type="numeric" default="2" hint="Constant Field Value"/>

	<cfproperty name="listener" type="org.cfcunit.framework.TestListener" hint=""/>
	<cfproperty name="parameters" type="org.cfcunit.service.TestParameters"/>
	<cfproperty name="result" type="org.cfcunit.framework.TestResult" hint=""/>
	<cfproperty name="tests" type="array" hint=""/>
	<cfproperty name="errors" type="array" hint=""/>
	<cfproperty name="failures" type="array" hint=""/>
	
	<!----------------------------------------------------------->
	
	<cfset this.SUCCESS_EXIT = 0>
	<cfset this.FAILURE_EXIT = 1>
	<cfset this.EXCEPTION_EXIT = 2>
	
	<cfset variables["SUCCESS_EXIT"] = 0>
	<cfset variables["FAILURE_EXIT"] = 1>
	<cfset variables["EXCEPTION_EXIT"] = 2>
	
	<cfset variables["listener"] = NULL>
	<cfset variables["result"] = NULL>
	<cfset variables["tests"] = NULL>
	<cfset variables["errors"] = NULL>
	<cfset variables["failures"] = NULL>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestRunner" access="public" output="false" hint="Constructs a TestRunner.">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="false" hint=""/>
		<cfargument name="parameters" type="TestParameters" required="false"/>
		
		<cfif StructKeyExists(arguments, "listener")>
			<cfset setListener(arguments.listener)>
		</cfif>
		
		<cfif structKeyExists(arguments, "parameters")>
			<cfset setParameters(arguments.parameters)>
		</cfif>
		
		<cfset variables.tests = ArrayNew(1)>
		<cfset variables.errors = ArrayNew(1)>
		<cfset variables.failures = ArrayNew(1)>
		
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

		<cfif IsObject(variables.listener)>
			<cfset result.addListener(variables.listener)>			
		</cfif>
		<cfset result.addListener(this)>
		
		<cfset arguments.suite.run(result)>
		
		<cfreturn result/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="execute" returntype="numeric" access="public" output="false" hint="This is the main entry point into this class.">
		<cfargument name="testCaseClass" type="string" required="true"/>
		
		<cftry>
			<cfset variables.result = start(arguments.testCaseClass)>

			<cfif NOT variables.result.wasSuccessful()>
				<cfreturn this.FAILURE_EXIT/>
			</cfif>
			
			<cfreturn this.SUCCESS_EXIT/>

			<cfcatch type="System.Exit">
				<cfthrow type="Exception.TestRunner.Exit" 
					message="#cfcatch.message#" 
					detail="#cfcatch.detail#" 
					errorcode="#cfcatch.errorCode#"/>
			</cfcatch>
			
			<cfcatch type="any">
				<cfthrow type="Exception.TestRunner" 
					message="#getFilteredTraceFromString(cfcatch.stacktrace)#"/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getResult" returntype="org.cfcunit.framework.TestResult" access="public" output="false" hint="">
		<cfreturn variables.result/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getTests" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.tests/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getErrors" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.fErrors/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getFailures" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.fFailures/>
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
		<cfset var suite = newObject("org.cfcunit.framework.TestSuite").init(testClass=test)>
		
		<cfreturn runWithObject(suite)/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runWithObject" returntype="org.cfcunit.framework.TestResult" access="private" output="false" hint="Runs a single test and collects its results.">
		<cfargument name="test" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		<cfset var runner = newObject("org.cfcunit.service.TestRunner")>
		
		<cfreturn runner.doRun(arguments.test)/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="setListener" returntype="void" access="public" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true"/>
		
		<cfset variables.listener = arguments.listener>
	</cffunction>
	
	
	<!----------------------------------------------------------->
	

	<cffunction name="setParameters" returntype="void" access="public" output="false">
		<cfargument name="parameters" type="org.cfcunit.service.TestParameters" required="true"/>
		
		<cfset variables.parameters = arguments.parameters>
	</cffunction>

	<!----------------------------------------------------------->
	
	<cffunction name="start" returntype="org.cfcunit.framework.TestResult" access="private" output="true" 
		throws="Exception"
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

	<cffunction name="callSuiteMethodForTestClass" returntype="org.cfcunit.framework.Test" access="private" output="false">
		<cfargument name="testClass" type="any" required="true"/>
		
		<cfset var test = "">
		
		<cfinvoke component="#arguments.testClass#" method="#SUITE_METHODNAME#" returnvariable="test">
			<cfif structKeyExists(variables, "parameters")>
				<cfinvokeargument name="parameters" value="#variables.parameters#"/>
			</cfif>
		</cfinvoke>
		
		<cfreturn test/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runFailed" returntype="void" access="private" output="false">
		<cfargument name="message" type="string" required="true"/>
		
		<cfthrow type="System.Exit" 
			message="#arguments.message#" 
			errorcode="#this.FAILURE_EXIT#"/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getLoader" returntype="org.cfcunit.runner.TestSuiteLoader" access="public" output="false" 
		hint="Always use the StandardTestSuiteLoader. Overridden from BaseTestRunner.">
		
		<!--- This method has no implementation. --->
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="testStarted" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
		
		<!--- This method has no implementation. --->
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testEnded" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
		
		<!--- This method has no implementation. --->
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testFailed" returntype="void" access="public" output="false">
		<cfargument name="status" type="numeric" required="true"/>
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<!--- This method has no implementation. --->
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>