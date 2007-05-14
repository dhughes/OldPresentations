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

<!---
$Id: TestingServiceTest.cfc,v 1.3 2006/12/09 09:12:18 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/tests/service/TestingServiceTest.cfc,v $
--->

<cfcomponent name="TestingServiceTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testDefaultConstructor" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testSuccessfulRun" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
		<cfset var listener = newTestListener()>
		<cfset var resultHandler = newResultHandler()>
		<cfset var testCaseClass = "org.cfcunit.tests.framework.Success">
		<cfset var parameters = newParameters()>
		<cfset var result = "">
		
		<cfset service.setListener(listener)>
		<cfset service.setResultHandler(resultHandler)>
		
		<cfset result = service.runTest(testCaseClass, parameters)>
		
		<cfset assertEqualsString("#testCaseClass#:SUCCESS", result)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testRunWithFailure" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
		<cfset var listener = newTestListener()>
		<cfset var resultHandler = newResultHandler()>
		<cfset var testCaseClass = "org.cfcunit.tests.framework.Success">
		<cfset var parameters = newParameters("Exception.TestRunner.Exit")>
		<cfset var result = "">
		
		<cfset service.setListener(listener)>
		<cfset service.setResultHandler(resultHandler)>
		
		<cfset result = service.runTest(testCaseClass, parameters)>

		<cfset assertEqualsString("#testCaseClass#:FAILURE", result)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="testRunWithError" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
		<cfset var listener = newTestListener()>
		<cfset var resultHandler = newResultHandler()>
		<cfset var testCaseClass = "org.cfcunit.tests.framework.Success">
		<cfset var parameters = newParameters("Exception.TestRunner.Failure")>
		<cfset var result = "">
		
		<cfset service.setListener(listener)>
		<cfset service.setResultHandler(resultHandler)>
		
		<cfset result = service.runTest(testCaseClass, parameters)>

		<cfset assertEqualsString("#testCaseClass#:ERROR", result)>
	</cffunction>


	<!------------------------------------------------------------------------------------>


	<cffunction name="testRunWithException" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
		<cfset var listener = newTestListener()>
		<cfset var resultHandler = newResultHandler()>
		<cfset var testCaseClass = "org.cfcunit.tests.framework.Success">
		<cfset var parameters = newParameters("Exception.TestRunner")>
		<cfset var result = "">
		
		<cfset service.setListener(listener)>
		<cfset service.setResultHandler(resultHandler)>
		
		<cfset result = service.runTest(testCaseClass, parameters)>

		<cfset assertEqualsString("#testCaseClass#:EXCEPTION", result)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testWithoutParameterMetadata" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
		
		<cfset assertFalse(service.hasParameters(), "There should not be any parameters.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testWithParameterMetadata" returntype="void" access="public" output="false">
		<cfset var service = newTestingService()>
		<cfset var parameterMetadata = newParameterMetadata()>
		
		<cfset service.setParameters(parameterMetadata)>
		
		<cfset assertTrue(service.hasParameters(), "There should be parameters.")>
		<cfset assertSameComponent(parameterMetadata, service.getParameters())>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testParameterMismatch" returntype="void" access="public" output="false">
		<cfset var service = newObject("cfcunit.service.TestingService").init()>
		<cfset var listener = newTestListener()>
		<cfset var resultHandler = newResultHandler()>
		<cfset var parameterMetadata = newParameterMetadata()>
		<cfset var testCaseClass = "org.cfcunit.tests.framework.Success">
		<cfset var testParams = newParameters()>

		<cfset var result = "">
		
		<cfset service.setListener(listener)>
		<cfset service.setResultHandler(resultHandler)>
		<cfset service.setParameters(parameterMetadata)>
		
		<cftry>
			<cfset result = service.runTest(testCaseClass, testParams)>
			
			<cfset fail("Exception.ParameterMismatch should have been thrown.")>
			
			<cfcatch type="Exception.ParameterMismatch">
			</cfcatch>
		</cftry>
	</cffunction>
	
	



	<!------------------------------------------------------------------------------------>
	<!--- These functions allow this class to act as a listener without having to create a separate class. --->
	
	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
	</cffunction>
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
	</cffunction>
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
	</cffunction>
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
	</cffunction>	
	

	<!------------------------------------------------------------------------------------>
	<!------------------------------------------------------------------------------------>

	
	<cffunction name="newTestingService" returntype="cfcunit.service.TestingService" access="private" output="false">
		<cfset var service = createObject("component", "TestingServiceTest_Service").init()>
		
		<cfreturn service/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newResultHandler" returntype="org.cfcunit.service.ResultHandler" access="private" output="false">
		<cfreturn createObject("component", "TestingServiceTest_ResultHandler").init()/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newTestListener" returntype="org.cfcunit.framework.TestListener" access="private" output="false">
		<cfset var listener = newObject("org.cfcunit.extensions.TestListenerProxy").init(this)>
		
		<cfreturn listener/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newParameters" returntype="org.cfcunit.service.TestParameters" access="private" output="false">
		<cfargument name="exceptionToThrow" type="string" required="false"/>
		
		<cfset var params = structNew()>
		
		<cfif structKeyExists(arguments, "exceptionToThrow")>
			<cfset params.exceptionToThrow = arguments.exceptionToThrow>
		</cfif>
		
		<cfreturn createObject("component", "TestingServiceTest_Parameters").init(params)/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newParameterMetadata" returntype="org.cfcunit.service.ParameterMetadata" access="private" output="false">
		<cfset var metadata = createObject("component", "MismatchingParameterMetadata").init()>

		<cfreturn metadata/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
</cfcomponent>