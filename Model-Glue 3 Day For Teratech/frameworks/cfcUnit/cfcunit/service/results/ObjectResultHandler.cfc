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

<cfcomponent name="ObjectResultHandler" extends="org.cfcunit.service.ResultHandler" output="false">

	<!--------------------------------------------------------------------->
	
	<cfproperty name="testResultBuilder" type="cfcunit.service.util.TestResultBuilder"/>
	<cfproperty name="results" type="cfcunit.service.types.AllResults"/>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="init" returntype="ObjectResultHandler" access="public" output="false">
		<cfargument name="testResultBuilder" type="cfcunit.service.util.TestResultBuilder" required="true"/>
		
		<cfset variables.testResultBuilder = arguments.testResultBuilder>
		<cfset variables.results = "">

		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------------->

	<cffunction name="getResults" returntype="any" access="public" output="false">
		<cfreturn variables.results/>
	</cffunction>
	
	<!--------------------------------------------------------------------->

	<cffunction name="onStart" returntype="void" access="public" output="false">
		<cfargument name="testClassName" type="string" required="true"/>
		
		<cfset variables.testClassName = arguments.testClassName>
		<cfset variables.results = CreateObject("component", "cfcunit.service.types.AllResults")>
	</cffunction>
	
	<!--------------------------------------------------------------------->

	<cffunction name="onSuccess" returntype="void" access="public" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true" hint=""/>
		<cfargument name="runner" type="org.cfcunit.service.TestRunner" required="true" hint=""/>
		
		<cfset variables.results.status = "SUCCESSFUL">
		<cfset variables.results.testResults = CreateObject("component", "cfcunit.service.types.TestResults")>
		<cfset variables.testResultBuilder.buildTestResult(variables.results.testResults, arguments.listener, arguments.runner)>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onError" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset variables.results.status = "ERROR">
		<cfset variables.results.errorResult = CreateObject("component", "cfcunit.service.types.ErrorResult")>
	</cffunction>
	
	<!--------------------------------------------------------------------->

	<cffunction name="onFailure" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset variables.results.status = "FAILURE">
		<cfset variables.results.failureResult = CreateObject("component", "cfcunit.service.types.FailureResult")>
		<cfset variables.results.failureResult.message = arguments.exception.message>
		<cfset variables.results.failureResult.detail = arguments.exception.detail>
		<cfset variables.results.failureResult.errorCode = arguments.exception.errorCode>
	</cffunction>
	
	<!--------------------------------------------------------------------->		

	<cffunction name="onException" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset variables.results.status = "EXCEPTION">
		<cfset variables.results.exceptionResult = CreateObject("component", "cfcunit.service.types.ExceptionResult")>
		<cfset variables.results.exceptionResult.stackTrace = arguments.exception.message>
	</cffunction>
	
	<!--------------------------------------------------------------------->

</cfcomponent>