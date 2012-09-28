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

<cfcomponent displayname="Interface: TestRunListener" extends="org.cfcunit.Object" output="false"
	hint="
			A listener interface for observing the execution of a test run. Unlike TestListener, this 
			interface uses only primitive objects, making it suitable for remote test execution.
		">
		
	<!------------------------------------------------------------------------------>
	
	<cfproperty name="STATUS_ERROR" displayname="public" type="numeric" default="0"/>
	<cfproperty name="STATUS_FAILURE" displayname="public" type="numeric" default="1"/>
	
	<cfset this.STATUS_ERROR = 0>
	<cfset this.STATUS_FAILURE = 1>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="testEnded" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="testFailed" returntype="void" access="public" output="false">
		<cfargument name="status" type="numeric" required="true"/>
		<cfargument name="testName" type="string" required="false"/>
		<cfargument name="trace" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="testRunEnded" returntype="void" access="public" output="false">
		<cfargument name="elapsedTime" type="numeric" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="testRunStarted" returntype="void" access="public" output="false">
		<cfargument name="testSuiteName" type="string" required="true"/>
		<cfargument name="testCount" type="numeric" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="testRunStopped" returntype="void" access="public" output="false">
		<cfargument name="elapsedTime" type="numeric" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="testStarted" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>

</cfcomponent>