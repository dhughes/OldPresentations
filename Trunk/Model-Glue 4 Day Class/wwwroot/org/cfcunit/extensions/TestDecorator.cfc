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

<cfcomponent displayname="TestDecorator" extends="org.cfcunit.framework.Assert"
	hint="
			A Decorator for Tests. Use TestDecorator as the base class
			for defining new test decorators. Test decorator subclasses
			can be introduced to add behaviour before or after a test
			is run.
		">

	<!--------------------------------------------------------------->
	
	<cfproperty name="test" type="org.cfcunit.framework.Test" hint=""/>

	<cfset variables["test"] = NULL>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestDecorator" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		
		<cfset super.init()>
		
		<cfset variables.test = arguments.test>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="basicRun" returntype="void" access="public" output="false" hint="The basic run behaviour.">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		
		<cfset variables.test.run(arguments.result)>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false">
		<cfreturn variables.test.countTestCases()/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		
		<cfset basicRun(arguments.result)>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn variables.test.toStringValue()/>
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="getTest" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfreturn variables.test/>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>