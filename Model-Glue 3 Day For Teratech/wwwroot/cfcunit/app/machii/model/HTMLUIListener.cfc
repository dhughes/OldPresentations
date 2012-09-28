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

<cfcomponent displayname="HTMLUIListener" extends="cfcunit.machii.framework.Listener" output="false" 
	hint="Manages the CFCUnit Test Application.">
	
	<!--------------------------------------------------------------------------->
	
	<cfproperty name="testRunnerClassName" type="string" hint=""/>
	<cfproperty name="testListenerClassName" type="string" hint=""/>
	
	<cfset NULL = "">
	
	<cfset variables["testRunnerClassName"] = NULL>
	<cfset variables["testListenerClassName"] = NULL>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="configure" returntype="void" access="public" output="false" 
		hint="Initialize this listener component."
		throws="Exception.MachII.MissingParameter">
		
		<cfset variables.testRunnerClassName = getParameter("TestRunnerClassName")>
		<cfset variables.testListenerClassName = getParameter("TestListenerClassName")>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="public" output="false" hint="">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" hint=""/>
		<!--- --->
		<cfset var testClassName = arguments.event.getArg("testClassName")>
		<cfset var errorHelper = newObject("org.cfcunit.service.ErrorHelper").init()>
		<cfset var listener = newObject(variables.testListenerClassName).init(errorHelper)>
		<cfset var runner = createTestRunner(listener, arguments.event)>
		<cfset var newArgs = StructNew()>

		<cfsetting showdebugoutput="#arguments.event.getArg('showdebug', false)#"/>
		
		<cftry>
			<cfset runner.execute(testClassName)>

			<cfset newArgs["testRunnerClassName"] = variables.testRunnerClassName>
			<cfset newArgs["testClassName"] = testClassName>
			<cfset newArgs["listener"] = listener>
			<cfset newArgs["testResults"] = runner.getResult()>
			
			<cfset announceEvent("TestDone", newArgs)>
				
			<cfcatch type="Exception.TestRunner.Failure">
				<cfset newArgs["exception"] = cfcatch>
				<cfset announceEvent("TestDoneWithErrors", newArgs)>
			</cfcatch>
			
			<cfcatch type="Exception.TestRunner.Exit">
				<cfset newArgs["message"] = cfcatch.message>
				<cfset newArgs["detail"] = cfcatch.detail>
				<cfset newArgs["errorCode"] = cfcatch.errorCode>
				
				<cfset announceEvent("TestFailed", newArgs)>
			</cfcatch>
			
			<cfcatch type="Exception.TestRunner">
				<cfset newArgs["stackTrace"] = cfcatch.message>
				
				<cfset announceEvent("TestFailedWithException", newArgs)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="loadParameterMetadata" returntype="void" access="public" output="false">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" hint=""/>
		
		<cfif structKeyExists(variables, "parameterMetadataFactory")>
			<cfset arguments.event.setArg("parameterMetadata", variables.parameterMetadataFactory.getParameterMetadata())>
		</cfif>
	</cffunction>	


	<!--------------------------------------------------------------------------->
	<!--------------------------------------------------------------------------->

	<cffunction name="createTestRunner" returntype="org.cfcunit.service.TestRunner" access="private" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="false"/>
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" hint=""/>
		
		<cfset var runnerArgs = structNew()>
		
		<cfif structKeyExists(arguments, "listener")>
			<cfset runnerArgs.listener = arguments.listener>
		</cfif>
		
		<cfif arguments.event.isArgDefined("parameters")>
			<cfset runnerArgs.parameters = arguments.event.getArg("parameters")>
		</cfif>

		<cfreturn createObject("component", "org.cfcunit.service.TestRunner").init(argumentCollection=runnerArgs)/>
	</cffunction>

	
	<!--------------------------------------------------------------------------->
	
	
	<cffunction name="newObject" returntype="WEB-INF.cftags.component" access="private" output="false" hint=""
		throws="Exception.NoSuchComponent,Exception.Instantiation">
		
		<cfargument name="type" type="string" required="true"/>
		<!--- --->
		<cfset var ret = NULL>
		
		<cftry>
			<cfset ret = CreateObject("component", arguments.type)>
			
			<cfcatch type="coldfusion.runtime.CfJspPage$NoSuchTemplateException">
				<cfthrow type="Exception.NoSuchComponent" message="Could not find the component '#arguments.Type#'"/>
			</cfcatch>
			
			<cfcatch type="any">
				<cfthrow type="Exception.Instantiation" 
					message="Could not instantiate object of type #arguments.type#"
					detail="#arguments.type#"/>
			</cfcatch>
		</cftry>
		
		<cfreturn ret/>
	</cffunction>

	<!--------------------------------------------------------------------------->
	
</cfcomponent>