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

<cfcomponent name="TestRunnerTest" extends="org.cfcunit.framework.TestCase" output="false">
	
	<!-------------------------------------------------------------------->
	
	
	<cfproperty name="runner" type="org.cfcunit.service.TestRunner"/>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
		<cfset var listener = newObject("org.cfcunit.extensions.TestListenerProxy").init(this)>
		
		<cfset variables.runner = newObject("org.cfcunit.service.TestRunner").init(listener)>
		<cfset variables.testStarted = false>
		<cfset variables.testEnded = false>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testSuccess" returntype="void" access="public" output="false">
		<cfset var runner = variables.runner>
		<cfset var testClassName = "org.cfcunit.tests.framework.OneTestCase">
		<cfset var result = "">
		
		<cfset runner.execute(testClassName)>
		
		<cfset assertTrue(variables.testStarted, "startTest() should have been called.")>
		<cfset assertTrue(variables.testEnded, "endTest() should have been called.")>
		
		<cfset result = runner.getResult()>
		
		<cfset assertTrue(result.wasSuccessful(), "Test should have been successful.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	

	<cffunction name="testError" returntype="void" access="public" output="false">
		<cfset var runner = variables.runner>
		<cfset var testClassName = "org.cfcunit.tests.BogusDude">
		
		<cftry>
			<cfset runner.execute(testClassName)>
			
			<cfset fail("'Exception.TestRunner.Exit' should have been thrown.")>
			
			<cfcatch type="Exception.TestRunner.Exit">
				<cfset assertEqualsString("", cfcatch.detail, "Detail should be empty.")>
				<cfset assertTrue(Find("Error: ", cfcatch.message, 1) is 1, "Message should begin with 'Error: '.")>
				<cfset assertEqualsNumber(runner.FAILURE_EXIT, cfcatch.errorCode, "errorCode NEQ #runner.FAILURE_EXIT#.")>
				<cfset assertEqualsNumber(runner.FAILURE_EXIT, cfcatch.code, "code NEQ #runner.FAILURE_EXIT#.")>
			</cfcatch>
		</cftry>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->


	<cffunction name="testFailure" returntype="void" access="public" output="false">
		<cfset var runner = variables.runner>
		<cfset var testClassName = "org.cfcunit.tests.framework.Failure">
		<cfset var result = "">
		
		<cfset runner.execute(testClassName)>
		
		<cfset result = runner.getResult()>
		
		<cfset assertEqualsNumber(1, result.failureCount(), "There should be one failure.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testExecuteWithParameter" returntype="void" access="public" output="false">
		<cfset var runner = variables.runner>
		<cfset var testClassName = "org.cfcunit.tests.service.TestRunnerTest_ParamSuite">
		<cfset var paramStruct = newStruct(testClassName="org.cfcunit.tests.framework.Failure")>
		<cfset var parameters = createObject("component", "Parameters").init(paramStruct)>
		<cfset var result = "">
		
		<cfset runner.setParameters(parameters)>
		
		<cfset runner.execute(testClassName)>
		<cfset result = runner.getResult()>
		
		<cfset assertEqualsNumber(1, result.failureCount(), "There should be one failure")>
	</cffunction>


	<!-------------------------------------------------------------------->
	
	

	<cffunction name="startTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="any" required="true"/>
		
		<cfset variables.testStarted = true>
	</cffunction>

	<cffunction name="endTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="any" required="true"/>
		
		<cfset variables.testEnded = true>
	</cffunction>

	<cffunction name="addFailure" returntype="void" access="public" output="false">
		<cfargument name="test" type="any" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<cfset assertEqualsString("AssertionFailedError", arguments.error.type)>
		<cfset assertEqualsString("No tests found in org.cfcunit.tests.framework.Failure", arguments.error.message)>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="newStruct" returntype="struct" access="private" output="false">
		<cfset var key = "">
		<cfset var struct = structNew()>
		
		<cfloop collection="#arguments#" item="key">
			<cfset struct[key] = arguments[key]>
		</cfloop>
		
		<cfreturn struct/>
	</cffunction>

	
	<!-------------------------------------------------------------------->
	
</cfcomponent>