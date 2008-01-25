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

	<cfproperty name="fCurrentTest" type="struct" hint=""/>
	<cfproperty name="fTests" type="array" hint=""/>
	<cfproperty name="fErrors" type="array" hint=""/>
	<cfproperty name="fFailures" type="array" hint=""/>
	<cfproperty name="fHelper" type="org.cfcunit.htmlui.ErrorHelper" hint=""/>
	
	<cfset variables.fCurrentTest = NULL>
	<cfset variables.fTests = NULL>
	<cfset variables.fErrors = NULL>
	<cfset variables.fFailures = NULL>
	<cfset variables.fHelper = NULL>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestListener" access="public" output="false" hint="">
		<cfset variables.fTests = ArrayNew(1)>
		<cfset variables.fErrors = ArrayNew(1)>
		<cfset variables.fFailures = ArrayNew(1)>
		<cfset variables.fHelper = newObject("org.cfcunit.htmlui.ErrorHelper").init()>
		
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getTests" returntype="array" access="public" output="false" hint="">
		<cfreturn variables.fTests/>
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
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>

		<cfset variables.fCurrentTest = StructNew()>
		<cfset variables.fCurrentTest["testName"] = arguments.test.getName()>
		<cfset variables.fCurrentTest["test"] = arguments.test.toStringValue()>
		<cfset variables.fCurrentTest["startTime"] = GetTickCount()>
		<cfset variables.fCurrentTest["hasFailure"] = FALSE>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>
		
		<cfset variables.fCurrentTest["endTime"] = GetTickCount()>
		<cfset variables.fCurrentTest["executionTime"] = Abs(variables.fCurrentTest.endTime - variables.fCurrentTest.startTime)>
		
		<cfif variables.fCurrentTest.hasFailure AND variables.fCurrentTest.failure.failureType IS "Error">
			<cfset variables.fCurrentTest.failure["exceptionInfo"] = variables.fHelper.getErrorInfo(variables.fCurrentTest.failure.exception)>
		</cfif>
		
		<cfset ArrayAppend(variables.fTests, variables.fCurrentTest)>
	</cffunction>
	
	<!----------------------------------------------------------->

	<cffunction name="addError" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>
		<cfargument name="error" type="any" required="true" hint=""/>

		<cfset variables.fCurrentTest["hasFailure"] = TRUE>
		<cfset variables.fCurrentTest["failure"] = StructNew()>
		
		<cfset variables.fCurrentTest["failure"]["test"] = arguments.test.toStringValue()>
		<cfset variables.fCurrentTest["failure"]["testName"] = arguments.test.getName()>
		<cfset variables.fCurrentTest["failure"]["exception"] = arguments.error>
		<cfset variables.fCurrentTest["failure"]["failureType"] = "Error">
		
		<cfset ArrayAppend(variables.fErrors, variables.fCurrentTest.failure)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true" hint=""/>
		<cfargument name="failure" type="any" required="true"/>

		<cfset variables.fCurrentTest["hasFailure"] = TRUE>
		<cfset variables.fCurrentTest["failure"] = StructNew()>
		
		<cfset variables.fCurrentTest["failure"]["test"] = arguments.test.toStringValue()>
		<cfset variables.fCurrentTest["failure"]["testName"] = arguments.test.getName()>
		<cfset variables.fCurrentTest["failure"]["exception"] = arguments.failure>
		<cfset variables.fCurrentTest["failure"]["failureType"] = "Failure">

		<cfset ArrayAppend(variables.fFailures, variables.fCurrentTest.failure)>
	</cffunction>
		
	<!----------------------------------------------------------->

</cfcomponent>