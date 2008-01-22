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

<cfcomponent name="AssertTest" extends="org.cfcunit.framework.TestCase">
	
	<!---------------------------------------------------------------------------->

	<cffunction name="init" returntype="AssertTest" access="public" output="false">
		<cfargument name="name" type="string" required="false" default=""/>
		<cfset super.init(arguments.name)>
		<cfreturn this/>
	</cffunction>

	<!---------------------------------------------------------------------------->
	<!---
		In the tests that follow, we can't use standard formatting for exception tests:
		
			<cftry>
				<cfset somethingThatShouldThrow()>
				<cfset fail()>
				
				<cfcatch type="AssertionFailedError">
				</cfcatch>
			</cftry>
		
		because fail() would never be reported.
	--->
	<!---------------------------------------------------------------------------->



	
	<!----------------------------------------------------------------------------------------------->
	<!--- BOOLEAN ASSERTIONS --->
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertTrue" returntype="void" access="public" output="false">
		<cfset assertTrue(TRUE)>
		
		<cftry>
			<cfset assertTrue(FALSE)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>

	<!---------------------------------------------------------------------------->	

	<cffunction name="testAssertFalse" returntype="void" access="public" output="false">
		<cfset assertFalse(FALSE)>
		
		<cftry>
			<cfset assertFalse(TRUE)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>

	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- D A T A T Y P E   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->

	<cffunction name="testAssertSimpleValue" returntype="void" access="public" output="false">
		<cfset assertSimpleValue("asc")>
		
		<cftry>
			<cfset assertSimpleValue(StructNew())>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertComplexValue" returntype="void" access="public" output="false">
		<cfset assertComplexValue(StructNew())>
		<cfset assertComplexValue(ArrayNew(1))>
		<cfset assertComplexValue(QueryNew("a"))>
		<cfset assertComplexValue(newObject("org.cfcunit.Object"))>
		
		<cftry>
			<cfset assertComplexValue("asd")>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertComponent" returntype="void" access="public" output="false">
		<cfset assertComponent(CreateObject("component", "org.cfcunit.Object"))>
		
		<cftry>
			<cfset assertComponent(ArrayNew(1))>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

	<cffunction name="testAssertObject" returntype="void" access="public" output="false">
		<cfset assertObject(CreateObject("component", "org.cfcunit.Object"))>
		
		<cftry>
			<cfset assertObject(StructNew())>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- E Q U A L I T Y   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->

	<cffunction name="testAssertEqualsArray" returntype="void" access="public" output="false" hint="Tests: assertEqualsArray()">
		<cfset var array1 = ListToArray("a,b,c,d,e", ",")>
		<cfset var array2 = ListToArray("a,b,c,d,e", ",")>
		<cfset var array3 = ListToArray("1,2,3,4,5", ",")>
		
		<cfset assertEqualsArray(array1, array2)>
		
		<cftry>
			<cfset assertEqualsArray(array1, array3)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsBoolean" returntype="void" access="public" output="false" hint="Tests: assertEqualsBoolean()">
		<cfset assertEqualsBoolean(TRUE, TRUE)>
		<cfset assertEqualsBoolean(FALSE, FALSE)>

		<cftry>
			<cfset assertEqualsBoolean(TRUE, FALSE)>
			<cfset fail()>
			
			<cfcatch type="AssertionFailedError">
				<!--- Go to next part of test --->
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfset assertEqualsBoolean(FALSE, TRUE)>

			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

	<cffunction name="testAssertEqualsString" returntype="void" access="public" output="false" hint="Tests: assertEqualsString()">
		<cfset var string1 = "test">
		<cfset var string2 = "test">
		<cfset var string3 = "testing">
		
		<cfset assertEqualsString(string1, string2)>
		
		<cftry>
			<cfset assertEqualsString(string1, string3)>
			
			<cfcatch type="AssertionFailedError.ComparisonFailure">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsStringCaseSensitive" returntype="void" access="public" output="false" hint="">
		<cfset var string1 = "test">
		<cfset var string2 = "Test">
		
		<cftry>
			<cfset assertEqualsString(string1, string2)>
			
			<cfcatch type="AssertionFailedError.ComparisonFailure">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsNumber" returntype="void" access="public" output="false" hint="Tests: assertEqualsNumber()">
		<cfset var expectedFailureMessage = NULL>
		
		<cfset assertEqualsNumber(1, 1)>
		<cfset assertEqualsNumber(1.3, 1.3)>
		<cfset assertEqualsNumber(6, (6 * .2) / .2, "Comparison of uncast integer to a calculated double failed.")>
		<cfset assertEqualsNumber(6, 6.0, "Comparison of integer to double failed.")>
		

		<!--- Compare two different integers. --->
		<cfset expectedFailureMessage = "assertEqualsNumber: expected=(1), actual=(2)">
		<cftry>
			<cfset assertEqualsNumber(1, 2)>
			<cfset fail("Assertion should have failed.")>
			
			<cfcatch type="AssertionFailedError">
				<cfif cfcatch.message IS "Assertion should have failed.">
					<cfrethrow/>
				</cfif>

				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
			</cfcatch>
		</cftry>


		<!--- Compare a decimal to an integer of different value. --->
		<cfset expectedFailureMessage = "assertEqualsNumber: expected=(1.5), actual=(12)">
		<cftry>
			<cfset assertEqualsNumber(1.5, 12)>
			<cfset fail("Assertion should have failed.")>
			
			<cfcatch type="AssertionFailedError">
				<cfif cfcatch.message IS "Assertion should have failed.">
					<cfrethrow/>
				</cfif>
				
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsQueryPasses" returntype="void" access="public" output="false">
		<cfset var query1 = QueryNew("a,b,c")>
		<cfset var query2 = QueryNew("a,b,c")>
		
		<cfset QueryAddRow(query1, 2)>
		<cfset QuerySetCell(query1, "a", 1, 1)>
		<cfset QuerySetCell(query1, "b", 2, 1)>
		<cfset QuerySetCell(query1, "c", 3, 1)>
		<cfset QuerySetCell(query1, "a", 11, 2)>
		<cfset QuerySetCell(query1, "b", 22, 2)>
		<cfset QuerySetCell(query1, "c", 33, 2)>

		<cfset QueryAddRow(query2, 2)>
		<cfset QuerySetCell(query2, "a", 1, 1)>
		<cfset QuerySetCell(query2, "b", 2, 1)>
		<cfset QuerySetCell(query2, "c", 3, 1)>
		<cfset QuerySetCell(query2, "a", 11, 2)>
		<cfset QuerySetCell(query2, "b", 22, 2)>
		<cfset QuerySetCell(query2, "c", 33, 2)>

		<cfset AssertEqualsQuery(query1, query2)>
	</cffunction>

	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsQueryFailsForRowCount" returntype="void" access="public" output="false">
		<cfset var query1 = QueryNew("a,b,c")>
		<cfset var query2 = QueryNew("a,b,c")>
		<cfset var expectedFailureMessage = "Query record counts do not match: expected=(2), actual=(0)">
		
		<cfset QueryAddRow(query1, 2)>
		<cfset QuerySetCell(query1, "a", 1, 1)>
		<cfset QuerySetCell(query1, "b", 2, 1)>
		<cfset QuerySetCell(query1, "c", 3, 1)>
		<cfset QuerySetCell(query1, "a", 11, 2)>
		<cfset QuerySetCell(query1, "b", 22, 2)>
		<cfset QuerySetCell(query1, "c", 33, 2)>

		<cftry>
			<cfset assertEqualsQuery(query1, query2)>
			
			<cfcatch type="AssertionFailedError">
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
				
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail("Queries with different rowcounts should not pass.")>
	</cffunction>

	<!---------------------------------------------------------------------------->

	<cffunction name="testAssertEqualsQueryFailsForColumnNames" returntype="void" access="public" output="false">
		<cfset var query1 = QueryNew("a,b,c")>
		<cfset var query2 = QueryNew("a,b,c,d")>
		<cfset var expectedFailureMessage = "Query column names do not match: expected=(A,B,C), actual=(A,B,C,D)">

		<cftry>
			<cfset assertEqualsQuery(query1, query2)>
			
			<cfcatch type="AssertionFailedError">
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
				
				<cfreturn/>
			</cfcatch>
		</cftry>

		<cfset fail("Queries with different columns should not pass.")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsQueryFailsForData" returntype="void" access="public" output="false">
		<cfset var query1 = QueryNew("a,b,c")>
		<cfset var query2 = QueryNew("a,b,c")>
		<cfset var expectedFailureMessage = "Query cells do not match: column=(B), row=(2), expected=(22), actual=(21)">
		
		<cfset QueryAddRow(query1, 2)>
		<cfset QuerySetCell(query1, "a", 1, 1)>
		<cfset QuerySetCell(query1, "b", 2, 1)>
		<cfset QuerySetCell(query1, "c", 3, 1)>
		<cfset QuerySetCell(query1, "a", 11, 2)>
		<cfset QuerySetCell(query1, "b", 22, 2)>
		<cfset QuerySetCell(query1, "c", 33, 2)>

		<cfset QueryAddRow(query2, 2)>
		<cfset QuerySetCell(query2, "a", 1, 1)>
		<cfset QuerySetCell(query2, "b", 2, 1)>
		<cfset QuerySetCell(query2, "c", 3, 1)>
		<cfset QuerySetCell(query2, "a", 11, 2)>
		<cfset QuerySetCell(query2, "b", 21, 2)>
		<cfset QuerySetCell(query2, "c", 31, 2)>

		<cftry>
			<cfset assertEqualsQuery(query1, query2)>
			
			<cfcatch type="AssertionFailedError">
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
				
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail("Queries with different field values should not pass.")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsStruct" returntype="void" access="public" output="false">
		<cfset var str1 = StructNew()>
		<cfset var str2 = StructNew()>
		<cfset var str3 = StructNew()>
		
		<cfset str1.a = "1">
		<cfset str1.b = "2">
		<cfset str1.c = "3">
		
		<cfset str2.a = "1">
		<cfset str2.b = "2">
		<cfset str2.c = "3">
		
		<cfset str3.x = "1">
		<cfset str3.y = "2">
		<cfset str3.z = "3">
		
		<cfset assertEqualsStruct(str1, str2)>
		
		<cftry>
			<cfset assertEqualsStruct(str1, str3)>
			
			<cfcatch type="any">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>

	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertEqualsStructCaseSensitive" returntype="void" access="public" output="false" 
		hint="
				It seems that struct comparisons in CFMX 6.x are case sensitive, but this was 
				fixed in version 7.
			">
		
		<cfset var str1 = StructNew()>
		<cfset var str2 = StructNew()>
		<cfset var str3 = StructNew()>

		<cfif server.ColdFusion.ProductName IS "ColdFusion" AND ListFirst(server.ColdFusion.ProductVersion, ",") IS 6>
			<cfset str1["a"] = "1">
			<cfset str1["b"] = "2">
			<cfset str1["c"] = "3">
			
			<cfset str2["a"] = "1">
			<cfset str2["b"] = "2">
			<cfset str2["c"] = "3">
			
			<cfset str3.a = "1">
			<cfset str3.b = "2">
			<cfset str3.c = "3">
			
			<cfset assertEqualsStruct(str1, str2)>
		
			<cftry>
				<cfset assertEqualsStruct(str1, str3)>
				
				<cfcatch type="any">
					<cfreturn/>
				</cfcatch>
			</cftry>
			
			<cfset fail("Structs str2 and str3 should not be equal.")>
		</cfif>
	</cffunction>
	
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- I D E N T I T Y   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertSameComponent" returntype="void" access="public" output="false">
		<cfset var system = CreateObject("java", "java.lang.System")>
		<cfset var obj1 = CreateObject("component", "org.cfcunit.Object")>
		<cfset var obj2 = CreateObject("component", "org.cfcunit.Object")>
		<cfset var obj3 = CreateObject("component", "AssertTest$Object").init("abc")>
		<cfset var obj4 = CreateObject("component", "AssertTest$Object").init("123")>
		<cfset var obj1Str = obj1.toStringValue()>
		<cfset var obj2Str = obj2.toStringValue()>
		<cfset var obj3Str = GetMetadata(obj3).name & "@" & system.identityHashCode(obj3)>
		<cfset var obj4Str = GetMetadata(obj4).name & "@" & system.identityHashCode(obj4)>
		<cfset var expectedFailureMessage = NULL>
		
		
		<!--- This should pass. --->
		<cfset assertSameComponent(obj1, obj1)>
		
		<!--- These objects have a method called "toStringValue()". --->
		<cfset expectedFailureMessage = "(obj1, obj2) expected same:<#obj1Str#> was not:<#obj2Str#>">
		<cftry>
			<cfset assertSameComponent(obj1, obj2, "(obj1, obj2)")>
			<cfset fail("obj1 and obj2 should not be the same.")>
			
			<cfcatch type="AssertionFailedError">
				<cfif cfcatch.message IS "obj1 and obj2 should not be the same.">
					<cfrethrow/>
				</cfif>
				
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
			</cfcatch>
		</cftry>

		
		<!--- These objects do not have the method "toStringValue()". --->
		<cfset expectedFailureMessage = "(obj3, obj4) expected same:<#obj3Str#> was not:<#obj4Str#>">
		<cftry>
			<cfset assertSameComponent(obj3, obj4, "(obj3, obj4)")>
			<cfset fail("obj3 and obj4 should not be the same.")>
					
			<cfcatch type="AssertionFailedError">
				<cfif cfcatch.message IS "obj3 and obj4 should not be the same.">
					<cfrethrow/>
				</cfif>

				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertSameStruct" returntype="void" access="public" output="false">
		<cfset var str1 = StructNew()>
		<cfset var str2 = StructNew()>
		
		<cfset assertSameStruct(str1, str1)>
		
		<cftry>
			<cfset assertSameStruct(str1, str2)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>

	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertNotSameComponent" returntype="void" access="public" output="false">
		<cfset var obj1 = CreateObject("component", "org.cfcunit.Object")>
		<cfset var obj2 = CreateObject("component", "org.cfcunit.Object")>
		
		<cfset assertNotSameComponent(obj1, obj2)>
		
		<cftry>
			<cfset assertNotSameComponent(obj1, obj1)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
		
	<cffunction name="testAssertNotSameStruct" returntype="void" access="public" output="false">
		<cfset var str1 = StructNew()>
		<cfset var str2 = StructNew()>
		
		<cfset assertNotSameStruct(str1, str2)>
		
		<cftry>
			<cfset assertNotSameStruct(str1, str1)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>

		<cfset fail()>
	</cffunction>
	
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- C O N T A I N M E N T   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertContainsString" returntype="void" access="public" output="false" hint="">
		<cfset var string = "This is a string.">
		<cfset var subString1 = "is a">
		<cfset var subString2 = "is not">
		
		<cfset assertContainsString(string, subString1)>
		
		<cftry>
			<cfset assertContainsString(string, subString2)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail("Substring match should have failed.")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertContainsStringCaseSensitive" returntype="void" access="public" output="false" hint="">
		<cfset var string = "This is a string.">
		<cfset var subString = "IS A">

		<cftry>
			<cfset assertContainsString(string, subString)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail("Case-sensitive substring match should have failed.")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertArrayContainsString" returntype="void" access="public" output="false" hint="">
		<cfset var array = ListToArray("testing,tested,test,tester", ",")>
		<cfset var string1 = "test">
		<cfset var string2 = "missing">
		
		<cfset assertArrayContainsString(array, string1)>
		
		<cftry>
			<cfset assertArrayContainsString(array, string2)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail("Should not have found string2 in array.")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertArrayContainsNumber" returntype="void" access="public" output="false" hint="">
		<cfset var array = ArrayNew(1)>

		<cfset array[1] = 1>
		<cfset array[2] = 2>
		<cfset array[3] = 3>
		
		<cfset assertArrayContainsNumber(array, 1)>
		<cfset assertArrayContainsNumber(array, 2.0)>
		<cfset assertArrayContainsNumber(array, 3*1)>
	</cffunction>
	
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- S T R I N G   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertRegexMatch" returntype="void" access="public" output="false" hint="">
		<cfset var successString = "abc">
		<cfset var failureString = "ab2">
		<cfset var regex = "[a-zA-Z]{3}">
		<cfset var expectedFailureMessage = "assertRegexMatch: Regular expression, '#regex#' does not match string.">
		
		<cfset assertRegexMatch(regex, successString)>
		
		<cftry>
			<cfset assertRegexMatch(regex, failureString)>
			<cfset fail("Regex should not match string.")>
			
			<cfcatch type="AssertionFailedError">
				<cfif cfcatch.message IS "Regex should not match string.">
					<cfrethrow/>
				</cfif>
				
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertNotRegexMatch" returntype="void" access="public" output="false" hint="">
		<cfset var successString = "123">
		<cfset var failureString = "abc">
		<cfset var regex = "[a-zA-Z]+">
		<cfset var expectedFailureMessage = "assertNotRegexMatch: Regular expression, '#regex#' matches string.">
		
		<cfset assertNotRegexMatch(regex, successString)>
		
		<cftry>
			<cfset assertNotRegexMatch(regex, failureString)>
			<cfset fail("Regex should match string.")>
			
			<cfcatch type="AssertionFailedError">
				<cfif cfcatch.message IS "Regex should match string.">
					<cfrethrow/>
				</cfif>
				
				<cfset assertEqualsString(expectedFailureMessage, cfcatch.message)>
			</cfcatch>
		</cftry>
	</cffunction>




	<!----------------------------------------------------------------------------------------------->
	<!--- N U L L   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertNotNullComponent" returntype="void" access="public" output="false">
		<cfset assertNotNullComponent(CreateObject("component", "org.cfcunit.Object"))>

		<cftry>
			<cfset assertNotNullComponent(CreateObject("component", "org.cfcunit.Null"))>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>

		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertNotNull" returntype="void" access="public" output="false">
		<cfset assertNotNull(CreateObject("component", "org.cfcunit.Object"))>

		<cftry>
			<cfset assertNotNull(NULL)>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertNull" returntype="void" access="public" output="false">
		<cfset assertNull(NULL, "'' is not NULL")>
		
		<cftry>
			<cfset assertNull(CreateObject("component", "org.cfcunit.Object"), "Component is not NULL")>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>

		<cfset fail("Component is NULL")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testAssertNullComponent" returntype="void" access="public" output="false">
		<cfset assertNullComponent(CreateObject("component", "org.cfcunit.Null"))>
		
		<cftry>
			<cfset assertNullComponent(CreateObject("component", "org.cfcunit.Object"))>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfset fail()>
	</cffunction>
	



	<!---------------------------------------------------------------------------->
	
	<cffunction name="testFail" returntype="void" access="public" output="false">
		<!--- Also, we are testing fail, so we can't rely on fail() working. 
			We have to throw the exception manually --->
		<cftry>
			<cfset fail()>
			
			<cfcatch type="AssertionFailedError">
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfthrow type="AssertionFailedError"/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

</cfcomponent>