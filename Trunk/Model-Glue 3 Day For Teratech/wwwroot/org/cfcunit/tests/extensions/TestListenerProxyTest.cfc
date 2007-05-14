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

<cfcomponent name="TestListenerProxyTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cfproperty name="testStarted" type="boolean"/>
	<cfproperty name="testEnded" type="boolean"/>
	<cfproperty name="errorAdded" type="boolean"/>
	<cfproperty name="failureAdded" type="boolean"/>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
		<cfset variables.testStarted = false>
		<cfset variables.testEnded = false>
		<cfset variables.errorAdded = false>
		<cfset variables.failureAdded = false>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testAddError" returntype="void" access="public" output="false">
		<cfset var proxy = newObject("org.cfcunit.extensions.TestListenerProxy").init(this)>
		
		<cfset assertFalse(variables.errorAdded)>
		
		<cftry>
			<cfthrow/>
			
			<cfcatch type="any">
				<cfset proxy.addError(this, cfcatch)>
			</cfcatch>
		</cftry>
		
		<cfset assertTrue(variables.errorAdded, "addError() should have been called.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testAddFailure" returntype="void" access="public" output="false">
		<cfset var proxy = newObject("org.cfcunit.extensions.TestListenerProxy").init(this)>
		
		<cfset assertFalse(variables.failureAdded)>
		
		<cftry>
			<cfthrow/>
			
			<cfcatch type="any">
				<cfset proxy.addFailure(this, cfcatch)>
			</cfcatch>
		</cftry>
		
		<cfset assertTrue(variables.failureAdded, "addFailure() should have been called.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testStartTest" returntype="void" access="public" output="false">
		<cfset var proxy = newObject("org.cfcunit.extensions.TestListenerProxy").init(this)>
		
		<cfset assertFalse(variables.testStarted)>
		
		<cfset proxy.startTest(this)>
		
		<cfset assertTrue(variables.testStarted, "testStarted() should have been called.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testEndTest" returntype="void" access="public" output="false">
		<cfset var proxy = newObject("org.cfcunit.extensions.TestListenerProxy").init(this)>
		
		<cfset assertFalse(variables.testEnded)>
		
		<cfset proxy.endTest(this)>
		
		<cfset assertTrue(variables.testEnded, "testEnded() should have been called.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<cfset variables.errorAdded = true>
	</cffunction>
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfset variables.failureAdded = true>
	</cffunction>
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.testEnded = true>
	</cffunction>
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.testStarted = true>
	</cffunction>

	
	<!------------------------------------------------------------------------------------>

</cfcomponent>