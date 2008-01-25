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

<cfcomponent displayname="TestSetup" extends="org.cfcunit.extensions.TestDecorator" output="false" 
	hint="
			A Decorator to set up and tear down additional fixture state.
			Subclass TestSetup and insert it into your tests when you want
			to set up additional state once before the tests are run.
		">
	
	<!------------------------------------------------------------>
	
	<cffunction name="init" returntype="TestSetup" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset super.init(arguments.test)>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------>
	
	<cffunction name="run" returntype="void" access="public" output="false"><br>
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		<!--- --->
		<cfset var prot = newObject("org.cfcunit.extensions.TestSetup$Protectable")>
		
		<cfset prot.init(variables, arguments.result)>		
		<cfset arguments.result.runProtected(this, prot)>
	</cffunction>
	
	<!------------------------------------------------------------>
	
	<cffunction name="setUp" returntype="void" access="private" output="false"
		throws="Exception" 
		hint="Sets up the fixture. Override to set up additional fixture state.">
	</cffunction>
	
	<!------------------------------------------------------------>
	
	<cffunction name="tearDown" returntype="void" access="private" output="false"
		throws="Exception" 
		hint="Tears down the fixture. Override to tear down the additional fixture state.">
	</cffunction>
	
	<!------------------------------------------------------------>

</cfcomponent>