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

<cfcomponent displayname="ComparisonFailure" extends="org.cfcunit.Object" output="false" 
	hint="Thrown when an assert equals for Strings failed.">
	
	<!---------------------------------------------------------------->
	
	<cfproperty name="fMessage" type="string" default=""/>
	<cfproperty name="fExpected" type="string" default=""/>
	<cfproperty name="fActual" type="string" default=""/>
	
	<cfset variables.fMessage = NULL>
	<cfset variables.fExpected = NULL>
	<cfset variables.fActual = NULL>
	
	<!---------------------------------------------------------------->
	
	<cffunction name="init" returntype="ComparisonFailure" access="public" output="false" hint="Constructs a comparison failure.">
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="expected" type="string" required="true"/>
		<cfargument name="actual" type="string" required="true"/>
		
		<cfset variables.fMessage = arguments.message>
		<cfset variables.fExpected = arguments.expected>
		<cfset variables.fActual = arguments.actual>
		
		<cfreturn this/>
	</cffunction>
	
	<!---------------------------------------------------------------->
	
	<cffunction name="getMessage" returntype="string" access="public" output="false" 
		hint="Returns '...' in place of common prefix and '...' in place of common suffix between expected and actual.">
		
		<cfset var end = NULL>
		<cfset var i = 0>
		<cfset var j = 0>
		<cfset var k = 0>
		<cfset var prefixEnd = 0>
		<cfset var suffixLen = 0>
		<cfset var expected = NULL>
		<cfset var actual = NULL>
		
		<cfif variables.fExpected IS NULL OR variables.fActual IS NULL>
			<cfreturn format(variables.fMessage, variables.fExpected, variables.fActual)/>
		</cfif>
		
		<cfset end = Min(Len(variables.fExpected), Len(variables.fActual))>
		
		<cfloop index="i" from="0" to="#end-1#">
			<cfset i = JavaCast("int", i)>
			<cfif Compare(variables.fExpected.charAt(i), variables.fActual.charAt(i))>
				<cfbreak/>
			</cfif>
		</cfloop>

		<!--- Find common suffix for both strings --->
		<cfset j = Len(variables.fExpected) - 1>
		<cfset k = Len(variables.fActual) - 1>
		<cfloop condition="k GTE i AND j GTE i">
			<cfset j = JavaCast("int", j)>
			<cfset k = JavaCast("int", k)>
			
			<cfif Compare(variables.fExpected.charAt(j), variables.fActual.charAt(k))>
				<cfbreak/>
			</cfif>
			
			<cfset j = j - 1>
			<cfset k = k - 1>
		</cfloop>
		
		<cfset i = JavaCast("int", i)>
		<cfset j = JavaCast("int", j)>
		<cfset k = JavaCast("int", k)>
		
		<cfif j LT i AND k LT i>
			<cfset expected = variables.fExpected>
			<cfset actual = variables.fActual>
		<cfelse>
			<cfset expected = variables.fExpected.substring(i, JavaCast("int", j+1))>
			<cfset actual = variables.fActual.substring(i, JavaCast("int", k+1))>
			
			<cfif i LTE end AND i GT 0>
				<!--- The two strings have a common prefix. --->
				<cfset expected = "..." & expected>
				<cfset actual = "..." & actual>
			</cfif>
			
			<cfif j LT Len(variables.fExpected) - 1>
				<cfset expected = expected & "...">
			</cfif>
			<cfif k LT Len(variables.fActual) - 1>
				<cfset actual = actual & "...">
			</cfif>
		</cfif>
		
		<cfreturn format(variables.fMessage, expected, actual)/>
	</cffunction>
	
	<!---------------------------------------------------------------->
	
	<cffunction name="throw" returntype="void" access="public" output="false">
		<cfset var stInfo = StructNew()>
		<cfset var data = NULL>
		
		<cfset stInfo.message = variables.fMessage>
		<cfset stInfo.expected = variables.fExpected>
		<cfset stInfo.actual = variables.fActual>
		
		<cfwddx action="cfml2wddx" input="#stInfo#" output="data" usetimezoneinfo="no"/>
		
		<cfthrow type="AssertionFailedError.ComparisonFailure"
			message="#getMessage()#"
			extendedinfo="#data#"/>
	</cffunction>
	
	<!---------------------------------------------------------------->
	
	<cffunction name="loadFromException" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		<!--- --->
		<cfset var stInfo = NULL>
		
		<cftry>
			<cfif arguments.exception.type IS "AssertionFailedError.ComparisonFailure">
				<cfwddx action="wddx2cfml" input="#arguments.exception.extendedinfo#" output="stInfo"/>
				<cfset init(stInfo.message, stInfo.expected, stInfo.actual)>
			</cfif>
			
			<cfcatch type="any">
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---------------------------------------------------------------->
	
	<cffunction name="format" returntype="string" access="private" output="false">
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="expected" type="string" required="true"/>
		<cfargument name="actual" type="string" required="true"/>
		<!--- --->
		<cfset var formatted = NULL>
		
		<cfif Len(arguments.message)>
			<cfset formatted = arguments.message & " ">
		</cfif>
		<cfset formatted = formatted & "expected:<#arguments.expected#> but was:<#arguments.actual#>">
		
		<cfreturn formatted/>
	</cffunction>
	
	<!---------------------------------------------------------------->

</cfcomponent>