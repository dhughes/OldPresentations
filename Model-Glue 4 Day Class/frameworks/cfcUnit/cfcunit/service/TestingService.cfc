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
$Id: TestingService.cfc,v 1.8 2006/12/16 10:07:51 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/TestingService.cfc,v $
--->

<cfcomponent name="TestingService" output="false"
	hint="
			This class is a simple service interface for running unit tests.
		">

	<!--------------------------------------------------------------------->
	

	<cfproperty name="resultHandler" type="cfcunit.service.results.ResultHandler"/>
	<!---<cfproperty name="preferences" type="org.cfcunit.util.Properties"/>--->
	<cfproperty name="parameters" type="org.cfcunit.service.ParameterMetadata"/>

	
	<!--------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestingService" access="public" output="false">
		<cfargument name="resultHandler" type="org.cfcunit.service.ResultHandler" required="false"/>
		<!---<cfargument name="preferences" type="org.cfcunit.util.Properties" required="false"/>--->
		<cfargument name="parameters" type="org.cfcunit.service.ParameterMetadata" required="false"/>
		
		<cfif StructKeyExists(arguments, "resultHandler")>
			<cfset setResultHandler(arguments.resultHandler)>
		</cfif>
		
		<!---
		<cfif structKeyExists(arguments, "preferences")>
			<cfset setPreferences(arguments.preferences)>
		</cfif>
		--->
		
		<cfif structKeyExists(arguments, "parameters")>
			<cfset setParameters(arguments.parameters)>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="setResultHandler" returntype="void" access="public" output="false">
		<cfargument name="resultHandler" type="org.cfcunit.service.ResultHandler" required="true"/>
		
		<cfset variables.resultHandler = arguments.resultHandler>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<!---
	<cffunction name="setPreferences" returntype="void" access="public" output="false">
		<cfargument name="preferences" type="org.cfcunit.util.Properties" required="true"/>
		
		<cfset variables.preferences = arguments.preferences>
	</cffunction>
	--->
	
	<!--------------------------------------------------------------------->

	<cffunction name="setParameters" returntype="void" access="public" output="false">
		<cfargument name="parameters" type="org.cfcunit.service.ParameterMetadata" required="true"/>
		
		<cfset variables.parameters = arguments.parameters>
	</cffunction>

	<!--------------------------------------------------------------------->
	
	<cffunction name="getParameters" returntype="org.cfcunit.service.ParameterMetadata" access="public" output="false">
		<cfreturn variables.parameters/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="hasParameters" returntype="boolean" access="public" output="false">
		<cfif structKeyExists(variables, "parameters")>
			<cfreturn true/>
		</cfif>
		
		<cfreturn false/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="setListener" returntype="void" access="public" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true"/>
		
		<cfset variables.listener = arguments.listener>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	

	<cffunction name="runTest" returntype="any" access="public" output="false" 
		hint="
				This method will execute the tests/test suite in the specified class. All the results
				from the tests is returned to the caller to allow an alternative front-end.
			">
		
		<cfargument name="testClassName" type="string" required="true" hint="Name of a TestCase/TestSuite subclass."/>
		<cfargument name="parameters" type="org.cfcunit.service.TestParameters" required="false"/>
		<!--- --->
		<cfset var listener = variables.listener>
		<cfset var runner = createTestRunner(listener, arguments)>
	
		<cftry>
			<cfset variables.resultHandler.onStart(arguments.testClassName)>
		
			<cfset runner.execute(arguments.testClassName)>
			
			<cfset variables.resultHandler.onSuccess(listener, runner)>

			<cfcatch type="Exception.TestRunner.Failure">
				<cfset variables.resultHandler.onError(cfcatch)>
			</cfcatch>
			
			<cfcatch type="Exception.TestRunner.Exit">
				<cfset variables.resultHandler.onFailure(cfcatch)>
			</cfcatch>
			
			<cfcatch type="Exception.TestRunner">
				<cfset variables.resultHandler.onException(cfcatch)>
			</cfcatch>
		</cftry>
		
		<cfreturn variables.resultHandler.getResults()/>
	</cffunction>
	
	
	<!--------------------------------------------------------------------->
	
	
	<cffunction name="createTestRunner" returntype="org.cfcunit.service.TestRunner" access="private" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="false"/>
		<cfargument name="runTestArguments" type="struct" required="true"/>
		
		<cfset var runnerArgs = structNew()>
		
		<cfif structKeyExists(arguments, "listener")>
			<cfset runnerArgs.listener = arguments.listener>
		</cfif>
		
		<cfif structKeyExists(arguments.runTestArguments, "parameters")>
			<cfif hasParameters()>
				<cfset arguments.runTestArguments.parameters.validate(getParameters())>
			</cfif>
			
			<cfset runnerArgs.parameters = arguments.runTestArguments.parameters>
		</cfif>
		
		<cfreturn createObject("component", "org.cfcunit.service.TestRunner").init(argumentCollection=runnerArgs)/>
	</cffunction>
	
	
	<!--------------------------------------------------------------------->
	
</cfcomponent>