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

<cfcomponent displayname="ResultPrinter" extends="org.cfcunit.framework.TestListener" output="false" hint="API for use by textui.TestRunner">
	
	<!------------------------------------------------------------------------------>
	
	<cfproperty name="fTestRunner" displayname="private" type="org.cfcunit.textui.TestRunner" access="private"/>
	<cfproperty name="fColumn" displayname="private" type="numeric" default="0" access="private"/>
	<cfproperty name="fMaxWidth" displayname="private" type="numeric" default="40" access="private"/>
	
	<!------------------------------------------------------------------------------>
	
	<cfset newLine = Chr(13) & Chr(10)>
	
	<cfset variables.fTestRunner = NULL>
	<cfset variables.fColumn = 0>
	<cfset variables.fMaxWidth = 40>
	<cfset variables.fOutput = NULL>
		
	<!------------------------------------------------------------------------------>
	
	<cffunction name="init" returntype="ResultPrinter" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>

		<cfset addString("E")>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfset addString("F")>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="elapsedTimeAsString" returntype="string" access="private" output="false" 
		hint="Returns the formatted string of the elapsed time. Duplicated from BaseTestRunner.">
		
		<cfargument name="runTime" type="numeric" required="true"/>
		
		<cfreturn ToString(arguments.runTime / 1000)/>
	</cffunction>
	
	<!----------------------------------------------------------->
		
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<!--- This does nothing. --->
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="print" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		<cfargument name="runTime" type="numeric" required="true"/>
		
		<cfset printHeader(arguments.runTime)>
		<cfset printErrors(arguments.result)>
		<cfset printFailures(arguments.result)>
		<cfset printFooter(arguments.result)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printDefect" returntype="void" access="public" output="false" hint="only public for testing purposes">
		<cfargument name="defect" type="org.cfcunit.framework.TestFailure" required="true"/>
		<cfargument name="count" type="numeric" required="true"/>
		
		<cfset printDefectHeader(arguments.defect, arguments.count)>
		<cfset printDefectTrace(arguments.defect)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printDefectHeader" returntype="void" access="public" output="false">
		<cfargument name="defect" type="org.cfcunit.framework.TestFailure" required="true"/>
		<cfargument name="count" type="numeric" required="true"/>
		
		<cfset addString(arguments.count & ") " & arguments.defect.failedTest().toStringValue())>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printDefects" returntype="void" access="public" output="false">
		<cfargument name="defects" type="array" required="true"/>
		<cfargument name="count" type="numeric" required="true"/>
		<cfargument name="type" type="string" required="true"/>
		<!--- --->
		<cfset var i = 0>
		<cfset var defect = NULL>
		
		<cfif arguments.count IS 0>
			<cfreturn/>
		<cfelseif arguments.count IS 1>
			<cfset addLine("There was " & arguments.count & " " & arguments.type & ":")>
		<cfelse>
			<cfset addLine("There were " & arguments.count & " " & arguments.type & "s:")>
		</cfif>
		
		<cfloop index="i" from="1" to="#ArrayLen(arguments.defects)#">
			<cfset defect = arguments.defects[i]>
			<cfset addLine(defect.toStringValue(), i)>
		</cfloop>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printDefectTrace" returntype="void" access="public" output="false">
		<cfargument name="defect" type="org.cfcunit.framework.TestFailure" required="true"/>
		
		<cfif NOT IsObject(variables.fTestRunner)>
			<cfset variables.fTestRunner = newObject("org.cfcunit.textui.TestRunner")>
		</cfif>
		
		<cfset addString(variables.fTestRunner.getFilteredTrace(arguments.defect.trace()))>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printErrors" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		
		<cfset printDefects(arguments.result.errors(), arguments.result.errorCount(), "error")>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printFailures" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		
		<cfset printDefects(arguments.result.failures(), arguments.result.failureCount(), "failure")>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printFooter" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		
		<cfset addLine()>
		<cfif arguments.result.wasSuccessful()>
			<cfset addLine("OK (" & arguments.result.runCount() & " test" & IIF(arguments.result.runCount() IS 1, "''", "'s'") & ")")>
		<cfelse>
			<cfset addLine("FAILURES!!!")>
			<cfset addLine("Tests run: " & arguments.result.runCount() & ",  Failures: " & arguments.result.failureCount() & ",  Errors: " & arguments.result.errorCount())>
		</cfif>
		<cfset addLine()>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="printHeader" returntype="void" access="public" output="false">
		<cfargument name="runTime" type="numeric" required="true"/>
		
		<!--- <cfset addLine()> --->
		<cfset addLine("Time: " & elapsedTimeAsString(arguments.runTime) & " seconds")>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset addString(".")>
		<cfset variables.fColumn = variables.fColumn + 1>

		<cfif variables.fColumn GT variables.fMaxWidth>
			<cfset addLine()>
			<cfset variables.fColumn = 0>
		</cfif>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getContent" returntype="string" access="public" output="false">
		<cfreturn variables.fOutput/>
	</cffunction>

	<cffunction name="resetContent" returntype="void" access="public" output="false">
		<cfset variables.fColumn = 0>
		<cfset variables.fOutput = NULL>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addLine" returntype="void" access="private" output="false">
		<cfargument name="line" type="string" required="false" default=""/>
		
		<cfset variables.fOutput = variables.fOutput & newLine & arguments.line>
	</cffunction>
	
	<cffunction name="addString" returntype="void" access="private" output="false">
		<cfargument name="string" type="string" required="true" default=""/>
		
		<cfset variables.fOutput = variables.fOutput & arguments.string>
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>