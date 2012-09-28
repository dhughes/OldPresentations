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
$Id: TestListenerProxy.cfc,v 1.2 2006/11/21 20:49:43 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/extensions/cfunit/TestListenerProxy.cfc,v $
--->

<cfcomponent name="TestListenerProxy" extends="org.cfcunit.Object" output="false" 
	hint="
			This listener gets notifications for all the events in CFUnit test cases when they
			are run, translates them to notifications suitable for cfcUnit, and passes them to
			a proxied cfcUnit TestListener object.
		">

	<!---------------------------------------------------------------------------------->
	
	<cfproperty name="listeners" type="array" hint=""/>
	
	<cfset variables["listeners"] = NULL>
	
	<!---------------------------------------------------------------------------------->

	<cffunction name="init" returntype="TestListenerProxy" access="public" output="false" hint="">
		<cfargument name="cfcUnitListener" type="org.cfcunit.framework.TestListener" required="false" hint=""/>
		<cfargument name="cfcUnitTestResult" type="org.cfcunit.framework.TestResult" required="false" hint=""/>

		<cfset variables.listeners = ArrayNew(1)>

		<cfif StructKeyExists(arguments, "cfcUnitListener")>
			<cfset ArrayAppend(variables.listeners, arguments.cfcUnitListener)>
		</cfif>
		
		<cfif StructKeyExists(arguments, "cfcUnitTestResult")>
			<cfset ArrayAppend(variables.listeners, arguments.cfcUnitTestResult)>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" hint="">
		<cfargument name="test" type="net.sourceforge.cfunit.framework.Test" required="true" hint=""/>
		<cfargument name="error" type="any" required="true" hint=""/>
		<!--- --->
		<cfset var testCase = CreateObject("component", "TestCase").init(arguments.test)>
		<cfset var i = 0>

		<!---
		<cftry>
			<cfthrow/>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#"/>
				<cfabort/>
			</cfcatch>
		</cftry>

		<cfdump var="#arguments.error#"/>
		<cfabort/>
		--->

		<cfloop index="i" from="1" to="#ArrayLen(variables.listeners)#">
			<cfset variables.listeners[i].addError(testCase, arguments.error)>
		</cfloop>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" hint="">
		<cfargument name="test" type="net.sourceforge.cfunit.framework.Test" required="true" hint=""/>
		<cfargument name="failure" type="any" required="true" hint=""/>
		<!--- --->
		<cfset var testCase = CreateObject("component", "TestCase").init(arguments.test)>
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.listeners)#">
			<cfset variables.listeners[i].addFailure(testCase, arguments.failure)>
		</cfloop>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" hint="">
		<cfargument name="test" type="net.sourceforge.cfunit.framework.Test" required="true" hint=""/>
		<!--- --->
		<cfset var testCase = CreateObject("component", "TestCase").init(arguments.test)>
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.listeners)#">
			<cfset variables.listeners[i].startTest(testCase)>
		</cfloop>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" hint="">
		<cfargument name="test" type="net.sourceforge.cfunit.framework.Test" required="true" hint=""/>
		<!--- --->
		<cfset var testCase = CreateObject("component", "TestCase").init(arguments.test)>
		<cfset var i = 0>

		<cfloop index="i" from="1" to="#ArrayLen(variables.listeners)#">
			<cfset variables.listeners[i].endTest(testCase)>
		</cfloop>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->

</cfcomponent>