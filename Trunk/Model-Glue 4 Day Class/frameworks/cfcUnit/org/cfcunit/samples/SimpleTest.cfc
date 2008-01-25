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

<cfcomponent name="SimpleTest" extends="org.cfcunit.framework.TestCase" output="false" hint="Some simple tests, none of which is supposed to pass.">

	<!------------------------------------------------------------------------->

	<cfproperty name="fValue1" type="numeric" hint=""/>
	<cfproperty name="fValue2" type="numeric" hint=""/>
	
	<cfset variables.fValue1 = NULL>
	<cfset variables.fValue2 = NULL>
	
	<!------------------------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="private" output="false" hint="">
		<cfset variables.fValue1 = 2>
		<cfset variables.fValue2 = 3>
	</cffunction>
	
	<!------------------------------------------------------------------------->

	<cffunction name="testAdd" returntype="void" access="public" output="false" hint="">
		<cfset var result = variables.fValue1 + variables.fValue2>

		<!--- Forced failure: result IS 5 --->
		<cfset assertTrue(result IS 6)>
	</cffunction>
	
	<!------------------------------------------------------------------------->

	<cffunction name="testDivideByZero" returntype="void" access="public" output="false" hint="">
		<cfset var zero = 0>
		<cfset var result = 8 / zero>
	</cffunction>
	
	<!------------------------------------------------------------------------->

	<cffunction name="testEquals" returntype="void" access="public" output="false" hint="This does nothing.">
		<cfset assertEqualsNumber(12, 12)>
		<cfset assertEqualsNumber(12.3, 12.3)>
		<cfset assertEqualsString("testString", "testString")>

		<cfset assertEqualsNumber(12, 13, "Size")>
		<cfset assertEqualsNumber(12.0, 11.99, "Capacity")>
	</cffunction>
	
	<!------------------------------------------------------------------------->

</cfcomponent>