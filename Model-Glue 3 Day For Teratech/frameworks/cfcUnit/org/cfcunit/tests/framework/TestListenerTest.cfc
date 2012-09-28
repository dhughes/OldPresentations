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

<cfcomponent displayname="TestListenerTest" extends="org.cfcunit.framework.TestCase" output="false" 
	hint="Test class used in SuiteTest">

	<!----------------------------------------------------------->
	
	<cfset variables.fResult = NULL>
	<cfset variables.fStartCount = 0>
	<cfset variables.fEndCount = 0>
	<cfset variables.fFailureCount = 0>
	<cfset variables.fErrorCount = 0>
	<cfset variables.interfaces = StructNew()>
	<cfset variables.interfaces.TestListener = NULL>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestListenerTest" access="public" output="false">
		<cfargument name="name" type="string" required="false"/>
	
		<cfset super.init(arguments.name)>
	
		<cfset variables.fResult = NULL>
		<cfset variables.fStartCount = 0>
		<cfset variables.fEndCount = 0>
		<cfset variables.fFailureCount = 0>
		<cfset variables.fErrorCount = 0>
		
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<cfset variables.fErrorCount = variables.fErrorCount + 1>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfset variables.fFailureCount = variables.fFailureCount + 1>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.fEndCount = variables.fEndCount + 1>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.fStartCount = variables.fStartCount + 1>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
		<cfset variables.fResult = newObject("org.cfcunit.framework.TestResult").init()>
		<cfset variables.fResult.addListener(getTestListenerInterface())>
		<cfset variables.fStartCount = 0>
		<cfset variables.fEndCount = 0>
		<cfset variables.fFailureCount = 0>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testError" returntype="void" access="public" output="false">
		<cfset var test = newTestCase("testError").init("noop")>
		
		<cfset test.run(variables.fResult)>
		<cfset assertEqualsNumber(1, variables.fErrorCount)>
		<cfset assertEqualsNumber(1, variables.fEndCount)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testFailure" returntype="void" access="public" output="false">
		<cfset var test = newTestCase("testFailure").init("noop")>
		
		<cfset test.run(variables.fResult)>
		<cfset assertEqualsNumber(1, variables.fFailureCount)>
		<cfset assertEqualsNumber(1, variables.fEndCount)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="testStartStop" returntype="void" access="public" output="false">
		<cfset var test = newTestCase("testStartStop").init("noop")>
		
		<cfset test.run(variables.fResult)>
		<cfset assertEqualsNumber(1, variables.fStartCount)>
		<cfset assertEqualsNumber(1, variables.fEndCount)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getTestListenerInterface" returntype="any" access="private" output="false">
		<cfset var obj = NULL>
		
		<cfif NOT IsObject(variables.interfaces.TestListener)>
			<cfset obj = newObject("org.cfcunit.tests.framework.TestListenerTest.TestListener").init(this)>
			<cfset variables.interfaces.TestListener = obj>
		</cfif>
		
		<cfreturn variables.interfaces.TestListener/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="newTestCase" returntype="org.cfcunit.framework.TestCase" access="private" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var base = "org.cfcunit.tests.framework.TestListenerTest.$">
		<cfset var fullName = "org.cfcunit.framework.TestCase">
		
		<cfif Len(arguments.name)>
			<cfset fullName = base & arguments.name>
		</cfif>
		
		<cftry>
			<cfreturn newObject(fullName)/>
		
			<cfcatch type="any">
				<cfreturn newObject("org.cfcunit.framework.TestCase")/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>