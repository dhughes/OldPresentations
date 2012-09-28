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

<cfcomponent displayname="TestFailure" extends="org.cfcunit.Object" output="false" 
	hint="A TestFailure collects a failed test together with the caught exception.">

	<!--------------------------------------------------------------->
	
	<cfproperty name="fFailedTest" displayname="private" type="org.cfcunit.framework.Test"/>
	<cfproperty name="fThrownException" displayname="private" type="exception"/>
	
	<!--------------------------------------------------------------->
	
	<cfset variables.fFailedTest = NULL>
	<cfset variables.fThrownException = NULL>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestFailure" access="public" output="false" hint="Constructs a TestFailure with the given test and exception.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset variables.fFailedTest = arguments.test>
		<cfset variables.fThrownException = arguments.exception>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="exceptionMessage" returntype="string" access="public" output="false">
		<cfreturn variables.fThrownException.message/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="failedTest" returntype="org.cfcunit.framework.Test" access="public" output="false" hint="Gets the failed test.">
		<cfreturn variables.fFailedTest/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="isFailure" returntype="boolean" access="public" output="false">
		<cfif ListFirst(variables.fThrownException.Type, ".") IS "AssertionFailedError">
			<cfreturn TRUE/>
		</cfif>
		<cfreturn FALSE/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="thrownException" returntype="any" access="public" output="false" hint="Gets the thrown exception.">
		<cfreturn variables.fThrownException/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn variables.fFailedTest.toStringValue() & ": " & variables.fThrownException.Message/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="trace" returntype="string" access="public" output="false">
		<cfreturn variables.fThrownException.StackTrace/>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>