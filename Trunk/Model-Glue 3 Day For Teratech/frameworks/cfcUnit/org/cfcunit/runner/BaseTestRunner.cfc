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

<cfcomponent displayname="BaseTestRunner" extends="org.cfcunit.framework.TestListener" output="false" 
	hint="Abstract base class for all test runners.">

	<!--------------------------------------------------------------->
	
	<cfproperty name="SUITE_METHODNAME" type="string" default="suite" hint="Name of method that returns 'TestSuite' object."/>
	<cfproperty name="STATUS_ERROR" type="numeric" default="0"/>
	<cfproperty name="STATUS_FAILURE" type="numeric" default="1"/>
	
	<cfproperty name="preferences" type="org.cfcunit.util.Properties" hint="Contains TestRunner options."/>
	<cfproperty name="fgMaxMessageLength" type="numeric" default="500" hint="Maximum length of messages."/>
	<cfproperty name="fgFilterStack" type="boolean" default="TRUE" hint=""/>
	<cfproperty name="fLoading" type="boolean" default="TRUE" hint="Flags the type of class loader to use."/>
	
	<!--------------------------------------------------------------->

	<cfset SUITE_METHODNAME = "suite">
	<cfset STATUS_ERROR = 0>
	<cfset STATUS_FAILURE = 1>
	
	<!---<cfset variables.fgPreferences = StructNew()>--->
	<cfset variables.fgMaxMessageLength = 500>
	<cfset variables.fgFilterStack = TRUE>
	<cfset variables.fLoading = TRUE>
	
	<cfset variables.fNulls = StructNew()>	
	
	<cfset variables.fPatterns =	"coldfusion.runtime.UDFMethod;" &
									"coldfusion.runtime.CfJspPage;" &
									"coldfusion.runtime.TemplateProxy;" &
									"coldfusion.filter;" &
									"coldfusion.CfmServlet;" &
									"coldfusion.bootstrap;" &
									"coldfusion.tagext;" &
									"jrunx.;" &
									"jrun.">
	<cfset variables.fPatterns = Replace(variables.fPatterns, "\", "\\", "all")>
	<cfset variables.fPatterns = "(" & ReplaceList(variables.fPatterns, ";,.", ")|(,\.") & ")">
	
	<!--------------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<!--- Delegate this method to abstract method 'testFailed()' --->
		<cfset testFailed(STATUS_ERROR, arguments.test, arguments.error)>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<!--- Delegate this method to abstract method 'testFailed()' --->
		<cfset testFailed(STATUS_FAILURE, arguments.test, arguments.failure)>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="clearStatus" returntype="void" access="private" output="false" hint="Clears the status message." displayname="abstract">
		<!--- Belongs in the GUI TestRunner class. --->
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="elapsedTimeAsString" returntype="string" access="public" output="false" hint="Returns the formatted string of the elapsed time.">
		<cfargument name="runTime" type="numeric" required="true"/>
		<cfreturn toString(arguments.runTime / 1000)/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
	
		<!--- Delegate this method to abstract method 'testEnded()' --->
		<cfset testEnded(arguments.test.toStringValue())>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="filterLine" returntype="boolean" access="private" output="false">
		<cfargument name="line" type="string" required="true"/>

		<cfif REFind(variables.fPatterns, arguments.line, 1, false)>
			<cfreturn TRUE/>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getFilteredTraceFromString" returntype="string" access="public" output="false" 
		hint="Filters stack frames from internal CFCUnit classes.">
		
		<cfargument name="stack" type="string" required="true"/>
		<!--- --->
		<cfset var line = NULL>
		<cfset var newLine = Chr(13) & Chr(10)>
		<cfset var filteredTrace = NULL>
		
		<cfif showStackRaw()>
			<cfreturn arguments.stack/>
		</cfif>
		
		<cftry>
			<cfloop list="#arguments.stack#" index="line" delimiters="#newLine#">
				<cfif Trim(line) NEQ NULL>
					<cfif NOT filterLine(line)>
						<cfset filteredTrace = filteredTrace & line & newLine>
					</cfif>
				</cfif>
			</cfloop>
			
			<cfcatch type="any">
				<!--- return the stack unfiltered --->
				<cfreturn arguments.stack/>
			</cfcatch>
		</cftry>
		
		<cfreturn filteredTrace/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getFilteredTraceFromException" returntype="string" access="public" output="false" hint="Returns a filtered stack trace.">
		<cfargument name="exception" type="any" required="true" hint="A ColdFusion exception object."/>
		<!--- --->
		<cfset var trace = arguments.exception.StackTrace>

		<cfreturn getFilteredTraceFromString(trace)/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getTest" returntype="org.cfcunit.framework.Test" access="public" output="false" 
		hint="Returns the Test corresponding to the given suite. This is a template method, subclasses override runFailed(), clearStatus()."
		throws="Exception,Exception.InvalidArgument,Exception.ClassNotFound">
		
		<cfargument name="suiteClassName" type="string" required="true"/>
		<!--- --->
		<cfset var testClass = NULL>
		<cfset var suite = NULL>
		<cfset var test = NULL>
		
		<cfif NOT Len(arguments.suiteClassName)>
			<cfset clearStatus()>
			<cfreturn nullTest()/>
		</cfif>
		
		<cftry>
			<!--- Get a component for the specified class name. --->
			<cfset testClass = loadSuiteClass(arguments.suiteClassName)>
			
			<!---
			<cfcatch type="Exception.ClassNotFound">
				<cfif Len(cfcatch.message)>
					<cfset runFailed("Class not found '#arguments.suiteClassName#'")>
				<cfelse>
					<cfset runFailed(cfcatch.message)>
				</cfif>
				
				<cfreturn nullTest()/>
			</cfcatch>
			--->
			
			<cfcatch type="any">
				<cfset runFailed("Error: " & cfcatch.toString())>
				<cfreturn nullTest()/>
			</cfcatch>
		</cftry>
		
		<cfif NOT (StructKeyExists(testClass, SUITE_METHODNAME) AND IsCustomFunction(testClass[SUITE_METHODNAME]))>
			<!--- try to extract a test suite automatically --->
			<cfset clearStatus()>
			
			<cfset suite = newObject("org.cfcunit.framework.TestSuite")>
			<cfinvoke component="#suite#" method="init">
				<cfinvokeargument name="testClass" value="#testClass#"/>
			</cfinvoke>
			
			<cfreturn suite/>
		</cfif>
		
		<cftry>
			<cfset test = callSuiteMethodForTestClass(testClass)>
			
			<cfcatch type="any">
				<cfset runFailed("Failed to invoke #SUITE_METHODNAME#():" & cfcatch.toString())>
				<cfreturn nullTest()/>
			</cfcatch>			
		</cftry>
		
		<cfset clearStatus()>
		<cfreturn test/>	
	</cffunction>
	
	
	<!--------------------------------------------------------------->
	
	<!--- This method exists so that subclasses can change the way that 'suite' is called. --->
	<cffunction name="callSuiteMethodForTestClass" returntype="org.cfcunit.framework.Test" access="private" output="false">
		<cfargument name="testClass" type="any" required="true"/>
		
		<cfset var test = "">
		
		<cfinvoke component="#arguments.testClass#" method="#SUITE_METHODNAME#" returnvariable="test"/>
		
		<cfreturn test/>
	</cffunction>
	
	
	<!--------------------------------------------------------------->
	
	<cffunction name="loadSuiteClass" returntype="WEB-INF.cftags.component" access="private" output="false" 
		throws="Exception.ClassNotFound"
		hint="Returns the loaded Class for a suite name.">
		
		<cfargument name="suiteClassName" type="string" required="true"/>
		
		<cfreturn newObject(arguments.suiteClassName)/>
		
		<!---
		<cftry>
			<cfreturn newObject(arguments.suiteClassName)/>
			
			<cfcatch type="Exception.NoSuchComponent">
				<cfthrow type="Exception.ClassNotFound" message="Class '#arguments.suiteClassName#' could not be found."/>
			</cfcatch>
		</cftry>
		--->
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="runFailed" returntype="void" access="private" output="false" 
		hint="Override to define how to handle a failed loading of a test suite." 
		displayname="abstract">
		
		<cfargument name="message" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<!---
	<cffunction name="getPreferences" returntype="org.cfcunit.util.Properties" access="private" output="false">
		<cfif not structKeyExists(variables, "preferences")>
			<cfset variables["preferences"] = newObject("org.cfcunit.util.Properties").init()>
			
			<cfset variables.preferences.setProperty("filterstack", "true")>
			
			<cfset readPreferences()>
		</cfif>
		
		<cfreturn variables.preferences/>
	</cffunction>
	--->
	
	<!--------------------------------------------------------------->
	
	<!---
	<cffunction name="getPreferencesFile" returntype="string" access="private" output="false">
		<cfset var home = createObject("
		<cfset var filename = "cfcunit.properties">
		
		<cfreturn expandPath("/org/cfcunit/
	</cffunction>
	--->
	
	<!--------------------------------------------------------------->
	
	<!---
	<cffunction name="readPreferences" returntype="void" access="private" output="false">
		<cfset var prefsFile = getPreferencesFile()>
		
		<cfif fileExists(prefsFile)>
		
		</cfif>
	</cffunction>
	--->
	
	<!--------------------------------------------------------------->
	
	<!---
	<cffunction name="savePreferences" returntype="void" access="private" output="false">
	</cffunction>
	--->
	
	<!--------------------------------------------------------------->
	
	<cffunction name="setLoading" returntype="void" access="private" output="false" hint="Sets the loading behaviour of the test runner.">
		<cfargument name="enable" type="boolean" required="true"/>
		<cfset variables.fLoading = arguments.enable>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<!---
	<cffunction name="setPreference" returntype="void" access="private" output="false">
		<cfargument name="key" type="string" required="true"/>
		<cfargument name="value" type="string" required="true"/>
	</cffunction>
	--->
	
	<!--------------------------------------------------------------->

	<!---
	<cffunction name="setPreferences" returntype="void" access="private" output="false">
		<cfargument name="preferences" type="any" required="true"/>
	</cffunction>
	--->
	
	<!--------------------------------------------------------------->
	
	<cffunction name="showStackRaw" returntype="boolean" access="private" output="false">
		<cfreturn NOT variables.fgFilterStack/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
	
		<!--- Delegate this method to abstract method 'testStarted()' --->
		<cfset testStarted(arguments.test.toStringValue())>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="testStarted" returntype="void" access="public" output="false" displayname="abstract">
		<cfargument name="testName" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>

	<!--------------------------------------------------------------->
	
	<cffunction name="testEnded" returntype="void" access="public" output="false" displayname="abstract">
		<cfargument name="testName" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="testFailed" returntype="void" access="public" output="false" displayname="abstract">
		<cfargument name="status" type="numeric" required="true"/>
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfthrow type="Exception.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="truncate" returntype="string" access="public" output="false" hint="Truncates a String to the maximum length.">
		<cfargument name="s" type="string" required="true"/>
		<!--- --->
		<cfset var truncatedString = arguments.s>
		
		<cfif variables.fMaxMessageLength NEQ -1>
			<cfif Len(truncatedString) GT variables.fMaxMessageLength>
				<cfset truncatedString = Left(truncatedString, variables.fMaxMessageLength) & "...">
			</cfif>
		</cfif>
		
		<cfreturn truncatedString/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="useReloadingTestSuiteLoader" returntype="boolean" access="private" output="false">
		<cfreturn variables.fLoading/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="nullTest" returntype="org.cfcunit.framework.Test" access="private" output="false">
		<cfif NOT StructKeyExists(variables.fNulls, "TestNull")>
			<cfset variables.fNulls.TestNull = newObject("org.cfcunit.framework.TestNull")>
		</cfif>
		<cfreturn variables.fNulls.TestNull/>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>