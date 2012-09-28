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

<cfcomponent name="TestListenerProxy" extends="org.cfcunit.framework.TestListener" output="false">
	
	<!------------------------------------------------------------------------------------>
	
	
	<cfproperty name="listener" type="any"/>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="init" returntype="TestListenerProxy" access="public" output="false">
		<cfargument name="listener" type="any" required="true"/>
		
		<cfset variables.listener = arguments.listener>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<cfset variables.listener.addError(arguments.test, arguments.error)>
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfset variables.listener.addFailure(arguments.test, arguments.failure)>
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.listener.endTest(arguments.test)>
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset variables.listener.startTest(arguments.test)>
	</cffunction>
	
	
	 <!------------------------------------------------------------------------------------>

</cfcomponent>