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
$Id: TestResultBuilder.cfc,v 1.3 2006/11/21 20:49:42 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/util/TestResultBuilder.cfc,v $
--->

<cfcomponent name="TestResultBuilder" output="false" hint="">

	<!-------------------------------------------------------------------------->
	
	<cfset NULL = "">
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestResultBuilder" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="buildTestResult" returntype="void" access="public" output="false" hint="">
		<cfargument name="results" type="cfcunit.service.types.TestResults" required="true" hint=""/>
		<cfargument name="listener" type="org.cfcunit.service.TestListener" required="true" hint=""/>
		<cfargument name="runner" type="org.cfcunit.service.TestRunner" required="true" hint=""/>
		<!--- --->
		<cfset var testResults = arguments.runner.getResult()>
		<cfset var tests = arguments.listener.getTests()>
		<cfset var failures = arguments.listener.getFailures()>
		<cfset var errors = arguments.listener.getErrors()>
		
		<cfset arguments.results.runCount = testResults.runCount()>
		<cfset arguments.results.failureCount = testResults.failureCount()>
		<cfset arguments.results.errorCount = testResults.errorCount()>
		
		<cfset buildTests(tests, arguments.results)>
		<cfset buildFailures(failures, arguments.results)>
		<cfset buildErrors(errors, arguments.results)>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	<!-------------------------------------------------------------------------->
	
	<cffunction name="buildTests" returntype="void" access="private" output="false" hint="">
		<cfargument name="tests" type="array" required="true" hint=""/>
		<cfargument name="results" type="cfcunit.service.types.TestResults" required="true" hint=""/>
		<!--- --->
		<cfset var i = 0>
		<cfset var currentTest = NULL>
		<cfset var result = NULL>
	
		<cfloop index="i" from="1" to="#ArrayLen(arguments.tests)#">
			<cfset currentTest = arguments.tests[i]>
			<cfset result = CreateObject("component", "cfcunit.service.types.TestResult")>
			
			<cfset result.testSuite = ListLast(currentTest.test, "()")>
			<cfset result.testCaseComponent = ListLast(currentTest.test, "().")>
			<cfset result.testCaseName = currentTest.testName>
			<cfset result.executionTime = currentTest.executionTime>
			
			<cfif currentTest.hasFailure>
				<cfset result.status = currentTest.failure.failureType>
				<cfset result.message = currentTest.failure.exception.Message>
			<cfelse>
				<cfset result.status = "Success">
				<cfset result.message = "">
			</cfif>
			
			<cfset ArrayAppend(arguments.results.tests, result)>
		</cfloop>
	</cffunction>

	<!-------------------------------------------------------------------------->

	<cffunction name="buildFailures" returntype="void" access="private" output="false" hint="">
		<cfargument name="failures" type="array" required="true" hint=""/>
		<cfargument name="results" type="cfcunit.service.types.TestResults" required="true" hint=""/>
		<!--- --->
		<cfset var i = 0>
		<cfset var currentFailure = NULL>
		<cfset var failure = NULL>

		<cfloop index="i" from="1" to="#ArrayLen(arguments.failures)#">
			<cfset currentFailure = arguments.failures[i]>
			<cfset failure = CreateObject("component", "cfcunit.service.types.TestFailure")>
			
			<cfset failure.testCaseComponent = ListFirst(ListRest(currentFailure.test, "("), ")")>
			<cfset failure.testCaseName = currentFailure.testName>
			<cfset failure.exception = currentFailure.exception.type>
			<cfset failure.message = currentFailure.exception.message>
			
			<cfset ArrayAppend(arguments.results.failures, failure)>
		</cfloop>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="buildErrors" returntype="void" access="private" output="false" hint="">
		<cfargument name="errors" type="array" required="true" hint=""/>
		<cfargument name="results" type="cfcunit.service.types.TestResults" required="true" hint=""/>
		<!--- --->
		<cfset var i = 0>
		<cfset var currentError = NULL>
		<cfset var error = NULL>
		<cfset var j = 0>
		<cfset var curItem = NULL>
		<cfset var traceElement = NULL>

		<cfloop index="i" from="1" to="#ArrayLen(arguments.errors)#">
			<cfset currentError = arguments.errors[i]>
			<cfset error = CreateObject("component", "cfcunit.service.types.TestError")>

			<cfset error.testCaseComponent = ListFirst(ListRest(currentError.test, "("), ")")>
			<cfset error.testCaseName = currentError.testName>
			<cfset error.cfmlExceptionType = currentError.exception.type>
			<cfset error.javaExceptionType = currentError.exceptionInfo.name>
			<cfset error.detail = currentError.exceptionInfo.detail>
			<cftry>
				<cfset error.message = currentError.exceptionInfo.message>
				<cfcatch type="any">
					<cfset error.message = "">
				</cfcatch>
			</cftry>

			<cfloop index="j" from="1" to="#ArrayLen(currentError.exceptionInfo.stackTrace)#">
				<cfset curItem = currentError.exceptionInfo.stackTrace[j]>
				<cfset traceElement = CreateObject("component", "cfcunit.service.types.errors.StackTraceElement")>
				
				<cfset traceElement.filename = curItem.filename>
				<cfset traceElement.lineNumber = curItem.lineNumber>
				<cfset traceElement.methodName = curItem.udfName>
				
				<cfset ArrayAppend(error.stackTrace, traceElement)>
			</cfloop>

			<cfif error.cfmlExceptionType IS "database">
				<cfset error.databaseError = buildDatabaseError(currentError)>
			</cfif>
		
			<cfset ArrayAppend(arguments.results.errors, error)>
		</cfloop>	
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="buildDatabaseError" returntype="cfcunit.service.types.errors.DatabaseError" access="private" output="false" hint="">
		<cfargument name="error" type="struct" required="true" hint=""/>
		<!--- --->
		<cfset var dbError = CreateObject("component", "cfcunit.service.types.errors.DatabaseError")>
		<cfset var i = 0>
		<cfset var param = NULL>
		<cfset var bindParam = NULL>
		
		<cfset dbError.datasource = arguments.error.exceptionInfo.dataSource>
		<cfset dbError.nativeErrorCode = arguments.error.exceptionInfo.nativeErrorCode>
		<cfset dbError.sqlState = arguments.error.exceptionInfo.sqlState>
		<cfset dbError.sqlStatement = arguments.error.exceptionInfo.sql>
		<cfset dbError.bindParameters = ArrayNew(1)>
		
		<cfloop index="i" from="1" to="#ArrayLen(arguments.error.exceptionInfo.where)#">
			<cfset param = currentError.exceptionInfo.where[i]>
			<cfset bindParam = CreateObject("component", "cfcunit.service.types.errors.DatabaseBindParameter")>
			
			<cfset bindParam.param = param.param>
			<cfset bindParam.type = param.properties.type>
			<cfset bindParam.sqlType = param.properties.sqltype>
			<cfif StructKeyExists(param.properties, "class")>
				<cfset bindParam.class = param.properties.class>			
			</cfif>
			<cfset bindParam.value = param.properties.value>

			<cfset ArrayAppend(dbError.bindParameters, bindParam)>
		</cfloop>

		<cfreturn dbError/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
</cfcomponent>