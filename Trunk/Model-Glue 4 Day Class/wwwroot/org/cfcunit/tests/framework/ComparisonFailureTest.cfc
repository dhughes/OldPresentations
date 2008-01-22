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

<cfcomponent displayname="ComparisonFailureTest" extends="org.cfcunit.framework.TestCase" output="false" hint="">
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="ComparisonFailureTest" access="public" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<cfset super.init(arguments.name)>
	
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorMessage" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure("a", "b", "c")>
		<cfset assertEqualsString("a expected:<b> but was:<c>", failure.getMessage())>
	</cffunction>

	<!--------------------------------------------------------------------------->

	<cffunction name="testComparisonErrorCaseSensitive" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure("a", "Bc", "bc")>
		<cfset assertEqualsString("a expected:<B...> but was:<b...>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorStartSame" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "ba", "bc")>
		<cfset assertEqualsString("expected:<...a> but was:<...c>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorEndSame" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "ab", "cb")>
		<cfset assertEqualsString("expected:<a...> but was:<c...>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorSame" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "ab", "ab")>
		<cfset assertEqualsString("expected:<ab> but was:<ab>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorStartAndEndSame" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "abc", "adc")>
		<cfset assertEqualsString("expected:<...b...> but was:<...d...>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorStartSameComplete" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "ab", "abc")>
		<cfset assertEqualsString("expected:<...> but was:<...c>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorEndSameComplete" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "bc", "abc")>
		<cfset assertEqualsString("expected:<...> but was:<a...>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorOverlapingMatches" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "abc", "abbc")>
		<cfset assertEqualsString("expected:<......> but was:<...b...>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorOverlapingMatches2" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "abcdde", "abcde")>
		<cfset assertEqualsString("expected:<...d...> but was:<......>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorWithActualNull" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, "a", NULL)>
		<cfset assertEqualsString("expected:<a> but was:<>", failure.getMessage())>
	</cffunction>
	
	<!--------------------------------------------------------------------------->
	
	<cffunction name="testComparisonErrorWithExpectedNull" returntype="void" access="public" output="false">
		<cfset var failure = createComparisonFailure(NULL, NULL, "a")>
		<cfset assertEqualsString("expected:<> but was:<a>", failure.getMessage())>
	</cffunction>

	<!--------------------------------------------------------------------------->
	
	<cffunction name="createComparisonFailure" returntype="org.cfcunit.framework.ComparisonFailure" access="private" output="false">
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="expected" type="string" required="true"/>
		<cfargument name="actual" type="string" required="true"/>
		<!--- --->
		<cfset var exception = newObject("org.cfcunit.framework.ComparisonFailure")>
		
		<cfset exception.init(arguments.message, arguments.expected, arguments.actual)>
		
		<cfreturn exception/>
	</cffunction>
	
	<!--------------------------------------------------------------------------->

</cfcomponent> 