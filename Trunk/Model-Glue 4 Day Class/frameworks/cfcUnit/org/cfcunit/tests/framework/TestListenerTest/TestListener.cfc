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

<cfcomponent displayname="TestListenerTest" extends="org.cfcunit.framework.TestListener" output="false"><br>

	<!----------------------------------------------------------->

	<cfset variables.fOwner = NULL>
	<cfset variables.fInitialized = FALSE>
	
	<!----------------------------------------------------------->
	
	<cffunction name="init" returntype="TestListener" access="public" output="false">
		<cfargument name="owner" type="org.cfcunit.tests.framework.TestListenerTest" required="true"/>
		
		<cfif variables.fInitialized>
			<cfthrow type="Exception"/>
		</cfif>
		
		<cfset variables.fOwner = arguments.owner>
		<cfset variables.fInitialized = TRUE>
		
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------->
		
	<cffunction name="objectID" returntype="numeric" access="public" output="false">
		<cfreturn variables.fOwner.objectID()/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getCFCMetadata" returntype="any" access="public" output="false">
		<cfreturn variables.fOwner.getCFCMetadata()/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="getHashCode" returntype="string" access="public" output="false">
		<cfreturn variables.fOwner.getHashCode()/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn variables.fOwner.toStringValue()/>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.fOwner.startTest(arguments.test)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.fOwner.endTest(arguments.test)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<cfset variables.fOwner.addError(arguments.test, arguments.error)>
	</cffunction>
	
	<!----------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfset variables.fOwner.addFailure(arguments.test, arguments.failure)>
	</cffunction>
	
	<!----------------------------------------------------------->

</cfcomponent>