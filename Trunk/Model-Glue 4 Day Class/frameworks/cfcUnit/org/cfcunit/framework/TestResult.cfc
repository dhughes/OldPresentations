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

<cfcomponent displayname="TestResult" extends="org.cfcunit.Object" output="false" 
	hint="
			A TestResult collects the results of executing a test case. It is an 
			instance of the Collecting Parameter pattern. The test framework 
			distinguishes between failures and errors. A failure is anticipated and 
			checked for with assertions. Errors are unanticipated exceptions.
		">
	
	<!----------------------------------------------------------->
	
	<cfproperty name="fErrors" access="private" type="array" hint=""/>
	<cfproperty name="fFailures" access="private" type="array" hint=""/>
	<cfproperty name="fListeners" access="private" type="struct" hint=""/>
	<cfproperty name="fRunTests" access="private" type="numeric" hint=""/>
	<cfproperty name="fStop" access="private" type="boolean" hint=""/>
	
	<cfset variables.fErrors = NULL>
	<cfset variables.fFailures = NULL>
	<cfset variables.fListeners = NULL>
	<cfset variables.fRunTests = NULL>
	<cfset variables.fStop = NULL>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestResult" access="public" output="false">
		<cfset variables.fErrors = ArrayNew(1)>
		<cfset variables.fFailures = ArrayNew(1)>
		<cfset variables.fListeners = StructNew()>
		<cfset variables.fRunTests = 0>
		<cfset variables.fStop = FALSE>
		
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false" hint="Adds an error to the list of errors.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		<!--- --->
		<cfset var errorObject = NULL>
		<cfset var key = NULL>

		<cfset errorObject = newObject("org.cfcunit.framework.TestFailure").init(arguments.test, arguments.error)>
		
		<cfset ArrayAppend(variables.fErrors, errorObject)>
		
		<cfloop collection="#variables.fListeners#" item="key">
			<cfset variables.fListeners[key].addError(arguments.test, arguments.error)>
		</cfloop>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="Adds a failure to the list of failures.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		<!--- --->
		<cfset var failureObject = NULL>
		<cfset var key = NULL>
		
		<cfset failureObject = newObject("org.cfcunit.framework.TestFailure").init(arguments.test, arguments.failure)>
		
		<cfset ArrayAppend(variables.fFailures, failureObject)>
		
		<cfloop collection="#variables.fListeners#" item="key">
			<cfset variables.fListeners[key].addFailure(arguments.test, arguments.failure)>
		</cfloop>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addListener" returntype="void" access="public" output="false" hint="Registers a TestListener.">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true"/>
		
		<cfset variables.fListeners[arguments.listener.objectID()] = arguments.listener>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="Informs the result that a test was completed.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<!--- --->
		<cfset var key = NULL>
		
		<cfloop collection="#variables.fListeners#" item="key">
			<cfset variables.fListeners[key].endTest(arguments.test)>
		</cfloop>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="errorCount" returntype="numeric" access="public" output="false" hint="Gets the number of detected errors.">
		<cfreturn ArrayLen(variables.fErrors)/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="errors" returntype="array" access="public" output="false" hint="Returns an array for the errors.">
		<cfset var i = 0>
		<cfset var copy = ArrayNew(1)>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fErrors)#">
			<cfset copy[i] = variables.fErrors[i]>
		</cfloop>
		
		<cfreturn copy/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="failureCount" returntype="numeric" access="public" output="false" hint="Gets the number of detected failures.">
		<cfreturn ArrayLen(variables.fFailures)/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="failures" returntype="array" access="public" output="false" hint="Returns an array for the failures.">
		<cfset var i = 0>
		<cfset var copy = ArrayNew(1)>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fFailures)#">
			<cfset copy[i] = variables.fFailures[i]>
		</cfloop>
		
		<cfreturn copy/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="listeners" returntype="array" access="public" output="false" hint="Returns an array of the listeners.">
		<cfset var key = NULL>
		<cfset var copy = ArrayNew(1)>
		
		<cfloop collection="#variables.fListeners#" item="key">
			<cfset ArrayAppend(copy, variables.fListeners[key])>
		</cfloop>
		
		<cfreturn copy/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="removeListener" returntype="void" access="public" output="false" hint="Unregisters a TestListener.">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true"/>
				
		<cfset StructDelete(variables.fListeners, arguments.listener.objectID())>		
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="false" hint="Runs a TestCase.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<!--- --->
		<cfset var prot = newObject("org.cfcunit.framework.TestResult.$run").init(arguments)>
		
		<cfset startTest(arguments.test)>
		
		<cfset runProtected(arguments.test, prot)>
		
		<cfset endTest(arguments.test)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runProtected" returntype="void" access="public" output="false" hint="Runs a test case.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="prot" type="org.cfcunit.framework.Protectable" required="true"/>
		
		<cftry>
			<cfset arguments.prot.protect()>
			
			<cfcatch type="AssertionFailedError">
				<cfset addFailure(arguments.test, cfcatch)>
			</cfcatch>
			
			<cfcatch type="any">
				<cfset addError(arguments.test, cfcatch)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="runCount" returntype="numeric" access="public" output="false" hint="Gets the number of run tests.">
		<cfreturn variables.fRunTests/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="shouldStop" returntype="boolean" access="public" output="false" hint="Checks whether the test run should stop.">
		<cfreturn variables.fStop/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="Informs the result that a test will be started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<!--- --->
		<cfset var count = arguments.test.countTestCases()>
		<cfset var key = NULL>
		
		<cfset variables.fRunTests = variables.fRunTests + count>
		
		<cfloop collection="#variables.fListeners#" item="key">
			<cfset variables.fListeners[key].startTest(arguments.test)>
		</cfloop>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="stop" returntype="void" access="public" output="false" hint="Marks that the test run should stop.">
		<cfset variables.fStop = TRUE>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="wasSuccessful" returntype="boolean" access="public" output="false" hint="Returns whether the entire test was successful or not.">
		<cfif failureCount() OR errorCount()>
			<cfreturn FALSE/>
		</cfif>
		<cfreturn TRUE/>
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>