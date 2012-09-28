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

<cfcomponent name="ArrayTest" extends="org.cfcunit.framework.TestCase" output="false" hint="A sample test case, testing CFMX Arrays.">

	<!----------------------------------------------------------------------->

	<cfproperty name="fEmpty" type="array" hint=""/>
	<cfproperty name="fFull" type="array" hint=""/>
	
	<cfset variables.fEmpty = NULL>
	<cfset variables.fFull = NULL>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="private" output="false" hint="">
		<cfset variables.fEmpty = ArrayNew(1)>
		<cfset variables.fFull = ArrayNew(1)>
		
		<cfset ArrayAppend(variables.fFull, Int(1))>
		<cfset ArrayAppend(variables.fFull, Int(2))>
		<cfset ArrayAppend(variables.fFull, Int(3))>
	</cffunction>

	<!----------------------------------------------------------------------->

	<cffunction name="testCapacity" returntype="void" access="public" output="false" hint="">
		<cfset var size = ArrayLen(variables.fFull)>
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="100">
			<cfset ArrayAppend(variables.fFull, i)>
		</cfloop>
		
		<cfset assertTrue(ArrayLen(variables.fFull) IS (100+size))>
	</cffunction>
	
	<!----------------------------------------------------------------------->

	<cffunction name="testDuplicate" returntype="void" access="public" output="false" hint="">
		<cfset var dupArray = Duplicate(variables.fFull)>
	
		<cfset assertTrue(ArrayLen(dupArray) IS ArrayLen(variables.fFull))>
		<cfset assertTrue(dupArray.contains(Int(1)))>
	</cffunction>
	
	<!----------------------------------------------------------------------->

	<cffunction name="testContains" returntype="void" access="public" output="false" hint="">
		<cfset assertTrue(variables.fFull.contains(Int(1)))>
		<cfset assertFalse(variables.fEmpty.contains(Int(1)))>
	</cffunction>
	
	<!----------------------------------------------------------------------->

	<cffunction name="testElementAt" returntype="void" access="public" output="false" hint="">
		<cfset var i = variables.fFull[1]>
		
		<cfset assertTrue(i IS 1)>
		
		<cftry>
			<cfset i = variables.fFull[ArrayLen(variables.fFull)+1]>
			
			<cfcatch type="coldfusion.runtime.CfJspPage$ArrayBoundException">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail("Should throw an 'coldfusion.runtime.CfJspPage$ArrayBoundException' exception.")>
	</cffunction>
	
	<!----------------------------------------------------------------------->

	<cffunction name="testRemoveAll" returntype="void" access="public" output="false" hint="">
		<cfset ArrayClear(variables.fFull)>
		<cfset ArrayClear(variables.fEmpty)>
		
		<cfset assertTrue(ArrayIsEmpty(variables.fFull))>
		<cfset assertTrue(ArrayIsEmpty(variables.fEmpty))>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="testArrayToList" returntype="void" access="public" output="false" hint="">
		<cfset var list = ArrayToList(variables.fFull, ",")>
		
		<cfset assertEqualsString("1,2,3", list)>
	</cffunction>
	
	<!----------------------------------------------------------------------->

</cfcomponent>