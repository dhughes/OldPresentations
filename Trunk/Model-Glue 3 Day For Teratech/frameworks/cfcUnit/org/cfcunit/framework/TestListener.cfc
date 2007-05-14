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

<cfcomponent displayname="Interface: TestListener" output="false" extends="org.cfcunit.Object" 
	hint="A Listener interface for test progress.">
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="Test" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="Test" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------->

</cfcomponent>