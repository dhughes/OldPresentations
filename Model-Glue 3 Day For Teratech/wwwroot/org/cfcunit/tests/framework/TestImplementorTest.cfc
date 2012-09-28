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

<cfcomponent displayname="TestImplementorTest" extends="org.cfcunit.framework.TestCase" output="false" 
	hint="Test an implementor of cfcunir.framework.Test other than TestCase or TestSuite.">

	<!-------------------------------------------------------------------------->
	
	<cfproperty name="fTest" type="org.cfcunit.tests.framework.TestImplementorTest.DoubleTestCase" hint=""/>
	
	<cfset variables.fTest = NULL>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestImplementorTest" access="public" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var testCase = NULL>
		
		<cfset super.init(arguments.name)>
		
		<cfset testCase = newObject("org.cfcunit.tests.framework.TestImplementorTest.$init").init()>
		
		<cfset variables.fTest = newObject("org.cfcunit.tests.framework.TestImplementorTest.DoubleTestCase")>
		<cfset variables.fTest.init(testCase)>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="testSuccessfulRun" returntype="void" access="public" output="false">
		<cfset var result = newObject("org.cfcunit.framework.TestResult").init()>

		<cfset variables.fTest.run(result)>

		<cfset assertEqualsNumber(fTest.countTestCases(), result.runCount())>
		<cfset assertEqualsNumber(0, result.errorCount())>
		<cfset assertEqualsNUmber(0, result.failureCount())>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="newTestCase" returntype="org.cfcunit.framework.TestCase" access="private" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var prefix = "org.cfcunit.tests.framework.TestImplementorTest.$">
		<cfset var fullName = "org.cfcunit.framework.TestCase">
		
		<cfif Len(arguments.name)>
			<cfset fullName = prefix & arguments.name>
		</cfif>
		
		<cftry>
			<cfreturn newObject(fullName)/>
			
			<cfcatch type="any">
				<cfreturn newObject("org.cfcunit.framework.TestCase")/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!-------------------------------------------------------------------------->

</cfcomponent>