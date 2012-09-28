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

<cfcomponent displayname="TextUIListener" extends="cfcunit.machii.framework.Listener" output="false" 
	hint="Manages the CFCUnit Test Application.">
	
	<!--------------------------------------------------------------------------->
	
	<cfproperty name="testRunnerClassName" type="string" hint=""/>
	<cfproperty name="resultPrinterClassName" type="string" hint=""/>
	
	<cfset NULL = "">
	
	<cfset variables["testRunnerClassName"] = NULL>
	<cfset variables["resultPrinterClassName"] = NULL>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="configure" returntype="void" access="public" output="false" 
		hint="Initialize this listener component."
		throws="Exception.MachII.MissingParameter">
		
		<cfset variables.testRunnerClassName = getParameter("TestRunnerClassName")>
		<cfset variables.resultPrinterClassName = getParameter("ResultPrinterClassName")>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="public" output="false" hint="">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true"/>
		<!--- --->
		<cfset var testClassName = arguments.event.getArg("testClassName")>
		<cfset var printer = newObject(variables.resultPrinterClassName)>
		<cfset var runner = newObject(variables.testRunnerClassName).init(printer)>
		<cfset var newArgs = StructNew()>
		<cfset var startTime = 0>
		<cfset var endTime = 0>
		<cfset var runTime = 0>


		<cfset startTime = getTickCount()>

		<cfset runner.execute(testClassName)>

		<cfset endTime = getTickCount()>
		<cfset runTime = abs(endTime - startTime)>
		
		<cfset printer.print(runner.getResult(), runTime)>
		
		<cfset newArgs.testRunnerClassName = variables.testRunnerClassName>
		<cfset newArgs.testClassName = testClassName>
		<cfset newArgs.printer = printer>
		
		<cfset announceEvent("TestDone", newArgs)>
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