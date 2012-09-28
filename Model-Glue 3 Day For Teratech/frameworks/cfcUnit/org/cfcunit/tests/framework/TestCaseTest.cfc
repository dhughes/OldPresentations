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

<cfcomponent displayname="TestCaseTest" extends="org.cfcunit.framework.TestCase" output="false" hint="A test case testing the testing framework.">
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="init" returntype="TestCaseTest" access="public" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		
		<cfset super.init(arguments.name)>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="testCaseToString" returntype="void" access="public" output="false" hint="">
		<cfset var testCaseClassName = getMetadata(this).name>
		
		<cfset assertEqualsString("testCaseToString(" & testCaseClassName & ")", toStringValue())>
	</cffunction> 
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testError" returntype="void" access="public" output="false" hint="">
		<cfset var error = newTestCase("testError").init("error")>
		<cfset verifyError(error)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testExceptionRunningAndTearDown" returntype="void" access="public" output="false" hint="">
		<cfset var test = newTornDown("testExceptionRunningAndTearDown")>
		<cfset var result = newObject("org.cfcunit.framework.TestResult").init()>
		<cfset var errors = NULL>
		<cfset var failure = NULL>
		
		<cfset test.run(result)>
		<cfset errors = result.errors()>
		<cfset failure = errors[1]>
		<cfset assertEqualsString("tearDown", failure.thrownException().getMessage())>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testFailure" returntype="void" access="public" output="false" hint="">
		<cfset failure = newTestCase("testFailure").init("failure")>
		<cfset verifyFailure(failure)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testNamelessTestCase" returntype="void" access="public" output="false" hint="">
		<cfset var test = newObject("org.cfcunit.framework.TestCase")>
		
		<cftry>
			<cfset test.run()>
			<cfset fail()>
			
			<cfcatch type="AssertionFailedError"></cfcatch>
		</cftry>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testNoArgTestCasePasses" returntype="void" access="public" output="false" hint="">
		<cfset var test = newObject("org.cfcunit.framework.TestSuite").init(NULL, newObject("org.cfcunit.tests.framework.NoArgTestCaseTest"))>
		<cfset var result = newObject("org.cfcunit.framework.TestResult").init()>
		
		<cfset test.run(result)>
		<cfset assertTrue(result.runCount() IS 1)>
		<cfset assertTrue(result.failureCount() IS 0)>
		<cfset assertTrue(result.errorCount() IS 0)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testRunAndTearDownFails" returntype="void" access="public" output="false" hint="">
		<cfset var fails = newTornDown("testRunAndTearDownFails")>
		
		<cfset verifyError(fails)>
		<cfset assertTrue(fails.fTornDown)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testSetupFails" returntype="void" access="public" output="false" hint="">
		<cfset var fails = newTestCase("testSetupFails").init("success")>
		
		<cfset verifyError(fails)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testSuccess" returntype="void" access="public" output="false" hint="">
		<cfset var success = newTestCase("testSuccess").init("success")>
		
		<cfset verifySuccess(success)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testTearDownAfterError" returntype="void" access="public" output="false" hint="">
		<cfset var fails = newTornDown()>
		
		<cfset verifyError(fails)>
		<cfset assertTrue(fails.fTornDown)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testTearDownFails" returntype="void" access="public" output="false" hint="">
		<cfset var fails = newTestCase("testTearDownFails").init("success")>
		
		<cfset verifyError(fails)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testTearDownSetupFails" returntype="void" access="public" output="false" hint="">
		<cfset var fails = newTornDown("testTearDownSetupFails")>
		
		<cfset verifyError(fails)>
		<cfset assertTrue(NOT fails.fTornDown)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="testWasRun" returntype="void" access="public" output="false" hint="">
		<cfset var test = newObject("org.cfcunit.tests.WasRun")>
		
		<cfset test.run()>
		<cfset assertTrue(test.fWasRun)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="verifyError" returntype="void" access="private" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.TestCase" required="true"/>
		<!--- --->
		<cfset var result = arguments.test.run()>
		
		<cfset assertTrue(result.runCount() IS 1)>
		<cfset assertTrue(result.failureCount() IS 0)>
		<cfset assertTrue(result.errorCount() IS 1)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="verifyFailure" returntype="void" access="private" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.TestCase" required="true"/>
		<!--- --->
		<cfset var result = arguments.test.run()>
		
		<cfset assertTrue(result.runCount() IS 1)>
		<cfset assertTrue(result.failureCount() IS 1)>
		<cfset assertTrue(result.errorCount() IS 0)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

	<cffunction name="verifySuccess" returntype="void" access="private" output="false" hint="">
		<cfargument name="test" type="org.cfcunit.framework.TestCase" required="true"/>
		<!--- --->
		<cfset var result = arguments.test.run()>
		
		<cfset assertTrue(result.runCount() IS 1)>
		<cfset assertTrue(result.failureCount() IS 0)>
		<cfset assertTrue(result.errorCount() IS 0)>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="newTornDown" returntype="org.cfcunit.tests.framework.TestCaseTest.TornDown" access="private" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var prefix = "org.cfcunit.tests.framework.TestCaseTest.$">
		<cfset var fullName = "org.cfcunit.tests.framework.TestCaseTest.TornDown">
		<cfset var object = NULL>
		
		<cfif Len(arguments.name)>
			<cfset fullName = prefix & arguments.name>
		</cfif>
		
		<cftry>
			<cfreturn newObject(fullName)/>
			
			<cfcatch type="any">
				<cfreturn newObject("org.cfcunit.tests.framework.TestCaseTest.TornDown")/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="newTestCase" returntype="org.cfcunit.framework.TestCase" access="private" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<!--- --->
		<cfset var prefix = "org.cfcunit.tests.framework.TestCaseTest.$">
		<cfset var fullName = "org.cfcunit.framework.TestCase">
		
		<cftry>
			<cfif Len(arguments.name)>
				<cfset fullName = prefix & arguments.name>
			</cfif>
			<cfreturn newObject(fullName)/>
			
			<cfcatch type="any">
				<cfreturn newObject("org.cfcunit.framework.TestCase")/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>