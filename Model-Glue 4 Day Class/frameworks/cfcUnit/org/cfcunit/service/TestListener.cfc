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

<cfcomponent name="TestListener" extends="org.cfcunit.framework.TestListener" output="false" hint="">

	<!----------------------------------------------------------->

	<cfproperty name="currentTest" type="struct" hint=""/>
	<cfproperty name="tests" type="array" hint=""/>
	<cfproperty name="errors" type="array" hint=""/>
	<cfproperty name="failures" type="array" hint=""/>
	<cfproperty name="helper" type="ErrorHelper" hint=""/>
	
	<cfset variables["currentTest"] = NULL>
	<cfset variables["tests"] = NULL>
	<cfset variables["errors"] = NULL>
	<cfset variables["failures"] = NULL>
	<cfset variables["helper"] = NULL>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestListener" access="public" output="false" hint="">
		<cfargument name="errorHelper" type="component" required="true"/>
		
		<cfset variables.helper = arguments.errorHelper>
		
		<cfset variables.tests = ArrayNew(1)>
		<cfset variables.errors = ArrayNew(1)>
		<cfset variables.failures = ArrayNew(1)>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!----------------------------------------------------------->
	
	<cffunction name="getCurrentTest" returntype="struct" access="public" output="false">
		<cfreturn variables.currentTest/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getTests" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.tests/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getErrors" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.errors/>
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="getFailures" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.failures/>
	</cffunction>

	<!----------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>

		<cfset var currentTest = structNew()>

		<cfset currentTest["testName"] = arguments.test.getName()>
		<cfset currentTest["test"] = arguments.test.toStringValue()>
		<cfset currentTest["startTime"] = GetTickCount()>
		<cfset currentTest["hasFailure"] = FALSE>
		
		<cfset variables.currentTest = currentTest>		
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>
		<!--- --->
		<cfset var currentTest = variables.currentTest>
		
		<cfset currentTest["endTime"] = GetTickCount()>
		<cfset currentTest["executionTime"] = Abs(currentTest.endTime - currentTest.startTime)>
		
		<cfif currentTest.hasFailure AND currentTest.failure.failureType IS "Error">
			<cfset currentTest.failure["exceptionInfo"] = variables.helper.getErrorInfo(currentTest.failure.exception)>
		</cfif>
		
		<cfset ArrayAppend(variables.tests, currentTest)>
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="addError" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>
		<cfargument name="error" type="any" required="true" hint=""/>
		<!--- --->
		<cfset var currentTest = variables.currentTest>

		<cfset currentTest["hasFailure"] = TRUE>
		<cfset currentTest["failure"] = StructNew()>
		
		<cfset currentTest["failure"]["test"] = arguments.test.toStringValue()>
		<cfset currentTest["failure"]["testName"] = arguments.test.getName()>
		<cfset currentTest["failure"]["exception"] = arguments.error>
		<cfset currentTest["failure"]["failureType"] = "Error">
		
		<cfset ArrayAppend(variables.errors, currentTest.failure)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>
		<cfargument name="failure" type="any" required="true"/>
		<!--- --->
		<cfset var currentTest = variables.currentTest>

		<cfset currentTest["hasFailure"] = TRUE>
		<cfset currentTest["failure"] = StructNew()>
		
		<cfset currentTest["failure"]["test"] = arguments.test.toStringValue()>
		<cfset currentTest["failure"]["testName"] = arguments.test.getName()>
		<cfset currentTest["failure"]["exception"] = arguments.failure>
		<cfset currentTest["failure"]["failureType"] = "Failure">

		<cfset ArrayAppend(variables.failures, currentTest.failure)>
	</cffunction>
		
	<!----------------------------------------------------------->

</cfcomponent>