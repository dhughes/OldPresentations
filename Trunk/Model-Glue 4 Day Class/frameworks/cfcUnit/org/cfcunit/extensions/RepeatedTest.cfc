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

<cfcomponent displayname="RepeatedTest" extends="org.cfcunit.extensions.TestDecorator" output="false" 
	hint="A Decorator that runs a test repeatedly.">
	
	<!-------------------------------------------------------------->
	
	<cfproperty name="timesRepeat" type="numeric" hint=""/>
	
	<cfset variables["timesRepeat"] = 0>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="init" returntype="RepeatedTest" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="repeat" type="numeric" required="true"/>
		
		<cfset super.init(arguments.test)>

		<cfif arguments.repeat LT 0>
			<cfthrow type="Exception.IllegalArgument" message="Repetition count must be GT 0"/>
		</cfif>
		<cfset variables.timesRepeat = arguments.repeat>
				
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false">
		<cfreturn super.countTestCases() * variables.timesRepeat/>
	</cffunction>
	
	<!-------------------------------------------------------------->

	<cffunction name="run" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		<!--- --->
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="#variables.timesRepeat#">
			<cfif arguments.result.shouldStop()>
				<cfbreak/>
			</cfif>
			<cfset super.run(arguments.result)>
		</cfloop>		
	</cffunction>
	
	<!-------------------------------------------------------------->

	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn super.toStringValue() & "(repeated)"/>
	</cffunction>
	
	<!-------------------------------------------------------------->

</cfcomponent>