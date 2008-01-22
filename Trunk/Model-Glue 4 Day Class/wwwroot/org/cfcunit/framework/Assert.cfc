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

<cfcomponent displayname="Assert" extends="org.cfcunit.framework.Test" output="false" 
	hint="
			A set of assertion methods. Messages are only displayed when an assert fails.
		">

	


	<!----------------------------------------------------------------------------------------------->
	<!--- B O O L E A N   A S S E R T I O N S --->	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertTrue" returntype="void" access="public" output="false" 
		throws="AssertionFailedError"
		hint="Asserts that a condition is true. If it isn't it throws an AssertionFailedError with the given message.">
		
		<cfargument name="condition" type="boolean" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var message = arguments.failureMessage>
		
		<cfif NOT arguments.Condition>
			<cfif NOT Len(message)>
				<cfset message = "assertTrue: condition=(#arguments.condition#)">
			</cfif>
			<cfset fail(message)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertFalse" returntype="void" access="public" output="false" 
		throws="AssertionFailedError"
		hint="Asserts that a condition is false. If it isn't it throws an AssertionFailedError with the given message.">
		
		<cfargument name="condition" type="boolean" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var message = arguments.failureMessage>
		
		<cfif arguments.Condition>
			<cfif NOT Len(message)>
				<cfset message = "assertFalse: condition=(#arguments.condition#)">
			</cfif>
			
			<cfset fail(message)>
		</cfif>
	</cffunction>
	
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- D A T A T Y P E   A S S E R T I O N S --->	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertSimpleValue" returntype="void" access="public" output="false">
		<cfargument name="value" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif NOT IsSimpleValue(arguments.Value)>
			<cfset fail(arguments.FailureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertComplexValue" returntype="void" access="public" output="false">
		<cfargument name="value" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif IsSimpleValue(arguments.Value)>
			<cfset fail(arguments.FailureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertComponent" returntype="void" access="public" output="false">
		<cfargument name="value" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif NOT isCFC(arguments.Value)>
			<cfset fail(arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertObject" returntype="void" access="public" output="false">
		<cfargument name="value" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif NOT IsObject(arguments.value)>
			<cfset fail(arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->

	<cffunction name="assertClass" returntype="void" access="public" output="false">
		<cfargument name="class" type="string" required="true"/>
		<cfargument name="object" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var classNameLen = Len(arguments.class)>
		<cfset var metadata = "">
		<cfset var message = arguments.failureMessage>
		<cfset var expectedClass = "">
		<cfset var actualClass = "">
		
		<cfif classNameLen IS 0>
			<cfthrow type="Exception.InvalidArgument" message="Parameter 'class' is zero length."/>
		</cfif>

		<cfif isCFC(arguments.object)>
			<cfset metadata = GetMetadata(arguments.object)>
			
			<cfloop condition="TRUE">
				<cfif NOT CompareNoCase(Right(metadata.name, classNameLen), arguments.class)>
					<cfreturn />
				<cfelseif StructKeyExists(metadata, "extends")>
					<cfset metadata = metadata.extends>
				<cfelse>
					<cfif NOT Len(message)>
						<cfset message = "CFC is not of type '#arguments.class#'.">
						<cfbreak/>
					</cfif>
				</cfif>
			</cfloop>
		<cfelse>
			<!--- This is a Java object (or some other type of object) --->
			<cfset expectedClass = CreateObject("java", "java.lang.Class").forName(arguments.class)>
			<cfset actualClass = arguments.object.getClass()>
			
			<cfif expectedClass.isAssignableFrom(actualClass)>
				<cfreturn />
			</cfif>
			
			<cfif NOT Len(message)>
				<cfset message = "Object is not of type '#arguments.class#'.">
			</cfif>
		</cfif>
		
		<cfset fail(message)/>
	</cffunction>
	
	


	<!----------------------------------------------------------------------------------------------->
	<!--- E Q U A L I T Y   A S S E R T I O N S --->
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsString" returntype="void" access="public" output="false"
		throws="AssertionFailedError.ComparisonFailure"
		hint="Asserts that two strings are equal. If they are not an AssertionFailedError is thrown with the given message.">
		
		<cfargument name="expected" type="string" required="true"/>
		<cfargument name="actual" type="string" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var exception = NULL>
		
		<cfif Compare(arguments.expected, arguments.actual)>
			<cfset exception = newObject("org.cfcunit.framework.ComparisonFailure")>
			<cfset exception.init(arguments.failureMessage, arguments.expected, arguments.actual)>
			<cfset exception.throw()>
		</cfif>
	</cffunction>

	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsNumber" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="Asserts that two numbers are equal. If they are not an AssertionFailedError is thrown with the given message.">
		
		<cfargument name="expected" type="numeric" required="true"/>
		<cfargument name="actual" type="numeric" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var message = arguments.failureMessage>

		<cfif Val(arguments.expected) NEQ Val(arguments.actual)>
			<cfif NOT Len(arguments.failureMessage)>
				<cfset message = "assertEqualsNumber: expected=(#arguments.expected#), actual=(#arguments.actual#)">
			</cfif>
			<cfset fail(message)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsDate" returntype="void" access="public" output="false"
		throws="AssertionFailedError">
	
		<cfargument name="expected" type="date" required="true"/>
		<cfargument name="actual" type="date" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var message = arguments.failureMessage>
		
		<cfif DateCompare(arguments.expected, arguments.actual)>
			<cfif NOT Len(arguments.failureMessage)>
				<cfset message = "assertEqualsDate: expected=#arguments.expected#, actual=#arguments.actual#">
			</cfif>
			<cfset fail(message)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsBoolean" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="Asserts that two booleans are equal. If they are not an AssertionFailedError is thrown with the given message.">
		
		<cfargument name="expected" type="boolean" required="true"/>
		<cfargument name="actual" type="boolean" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif NOT (arguments.expected IS arguments.actual)>
			<cfset fail(arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsStruct" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that two Structs are equal (value comparision). If they are not an 
				AssertionFailedError is thrown with the given message.
			">
		
		<cfargument name="expected" type="struct" required="true"/>
		<cfargument name="actual" type="struct" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif NOT arguments.expected.equals(arguments.actual)>
			<cfset fail(arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->

	<cffunction name="assertEqualsArray" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="Asserts that two Array are equal. If they are not an AssertionFailedError is thrown with the given message.">
		
		<cfargument name="expected" type="array" required="true"/>
		<cfargument name="actual" type="array" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif NOT arguments.expected.equals(arguments.actual)>
			<cfset fail(arguments.failureMessage)>
		</cfif>
	</cffunction>

	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsQuery" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="Asserts that two Queries are equal. If they are not an AssertionFailedError is thrown with the given message.">
		
		<cfargument name="expected" type="query" required="true"/>
		<cfargument name="actual" type="query" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var i = 0>
		<cfset var colName = NULL>
		<cfset var expectedColumnNames = ListSort(arguments.expected.columnList, "text", "asc", ",")>
		<cfset var actualColumnNames = ListSort(arguments.actual.columnList, "text", "asc", ",")>
		<cfset var expectedCount = arguments.expected.recordCount>
		<cfset var actualCount = arguments.actual.recordCount>
		<cfset var expectedValue = NULL>
		<cfset var actualValue = NULL>
		<cfset var message = arguments.failureMessage>

		<!--- Test to make sure that the column names match. --->
		<cfif expectedColumnNames NEQ actualColumnNames>
			<cfif NOT Len(message)>
				<cfset message = "Query column names do not match: expected=(#expectedColumnNames#), actual=(#actualColumnNames#)">
			</cfif>
			
			<cfset fail(message)>
		</cfif>
		
		<!--- Test to make sure that the queries have the same number of rows. --->
		<cfif arguments.expected.recordCount NEQ arguments.actual.recordCount>
			<cfif NOT Len(message)>
				<cfset message = "Query record counts do not match: expected=(#expectedCount#), actual=(#actualCount#)">
			</cfif>

			<cfset fail(message)>
		</cfif>

		<!--- Test to make sure that the queries contain the same data. --->
		<cfloop list="#arguments.expected.columnList#" index="colName" delimiters=",">

			<!--- Loop over each record for the given field and compare it to the actual value. --->
			<cfloop query="arguments.expected">
				<cfset i = arguments.expected.currentRow>
				
				<cfif arguments.expected[colName][i] NEQ arguments.actual[colName][i]>
					<cfif NOT Len(message)>
						<cfset expectedValue = arguments.expected[colName][i]>
						<cfset actualValue = arguments.actual[colName][i]>
						<cfset message = "Query cells do not match: column=(#colName#), row=(#i#), expected=(#expectedValue#), actual=(#actualValue#)">
					</cfif>
				
					<cfset fail(message)>
				</cfif>
			</cfloop>

		</cfloop>
	</cffunction>

	<!-------------------------------------------------------------------------------->
	
	<!--- NO TESTS YET
	<cffunction name="assertEquals" returntype="void" access="public" output="false" 
		throws="AssertionFailedError"
		hint="
				Asserts that two values are equal. If they are not an AssertionFailedError 
				is thrown with the given message.
			">
		
		<cfargument name="expected" type="any" required="true"/>
		<cfargument name="actual" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif IsSimpleValue(arguments.expected)>
			<cfif IsSimpleValue(arguments.actual)>
				<cfif arguments.expected NEQ arguments.actual>
					<cfset fail(arguments.failureMessage)>
				</cfif>
			<cfelse>
				<cfset fail(arguments.failureMessage)>
			</cfif>
		<cfelse>
			<cfif IsObject(arguments.expected)>
				<cfif NOT IsObject(arguments.actual)>
					<cfset fail(arguments.failureMessage)>
				</cfif>
				
				<cfif IsCFC(arguments.expected)>
					<cfif NOT IsCFC(arguments.actual)>
						<cfset fail(arguments.failureMessage)>
					</cfif>
					<!--- Compare the contents of two Components --->
					
				<cfelseif NOT arguments.expected.equals(arguments.actual)>
					<cfset fail(arguments.failureMessage)>
				</cfif>				
			<cfelse>	
				<cfif IsStruct(arguments.expected)>
					<cfif NOT IsStruct(arguments.actual)>
						<cfset fail(arguments.failureMessage)>
					<cfelseif NOT arguments.expected.equals(arguments.actual)>
						<cfset fail(arguments.failureMessage)>
					</cfif>
				<cfelseif IsArray(arguments.expected)>
					<cfif NOT IsArray(argumentes.actual)>
						<cfset fail(arguments.failureMessage)>
					<cfelseif NOT arguments.expected.equals(arguments.actual)>
						<cfset fail(arguments.failureMessage)>
					</cfif>
				<cfelseif IsQuery(arguments.expected)>
					<cfif NOT IsQuery(arguments.actual)>
						<cfset fail(arguments.failureMessage)>
					<cfelseif NOT arguments.expected.equals(arguments.actual)>
						<cfset fail(arguments.failureMessage)>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cffunction>

	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsJavaObject" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that two java objects are equal. If they are not an 
				AssertionFailedError is thrown with the given message.
			">
		
		<cfargument name="expected" type="any" required="true"/>
		<cfargument name="actual" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cftry>
			<cfif arguments.expected.equals(arguments.actual)>
				<cfreturn/>
			</cfif>
			
			<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfset fail(arguments.failureMessage)>	
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertEqualsComponent" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that two components are equal. If they are not an 
				AssertionFailedError is thrown with the given message.
			">
		
		<cfargument name="expected" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="actual" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cftry>
			<cfif arguments.expected.equalsObject(arguments.actual)>
				<cfreturn/>
			</cfif>
			
			<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfset fail(arguments.failureMessage)>
	</cffunction>
	--->
	
	
	

	<!----------------------------------------------------------------------------------------------->
	<!--- I D E N T I T Y   A S S E R T I O N S --->	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertSameStruct" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that two structs refer to the same struct. If they are not an 
				AssertionFailedError is thrown with the given message.
			">
		
		<cfargument name="expected" type="struct" required="true"/>
		<cfargument name="actual" type="struct" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var testKey = CreateUUID()>
		<cfset var success = FALSE>
		<cfset var strExpected = NULL>
		<cfset var strActual = NULL>
		
		<cfloop condition="TRUE">
			<cfif NOT (StructKeyExists(arguments.expected, testKey) OR StructKeyExists(arguments.actual, testKey))>
				<cfbreak/>
			</cfif>
			<cfset testKey = CreateUUID()>
		</cfloop>
		
		<cfset arguments.actual[testKey] = testKey>
		<cfset success = StructKeyExists(arguments.expected, testKey)>
		<cfset StructDelete(arguments.actual, testKey)>
		
		<cfif NOT success>
			<cfset failNotSame(arguments.failureMessage, arguments.expected.toString(), arguments.actual.toString())>
		</cfif>		
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertSameComponent" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				<p>Asserts that two components refer to the same object. If they are not an 
				AssertionFailedError is thrown with the given message.</p>
				<p>If the two variables do not refer to the same object, it helps if both 
				objects have a method called 'toStringValue()' that can be used to create 
				a textual representation of the objects in the failure message.</p>
			">
		
		<cfargument name="expected" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="actual" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var testKey = CreateUUID()>
		<cfset var success = FALSE>
		<cfset var strExpected = NULL>
		<cfset var strActual = NULL>
		<cfset var system = CreateObject("java", "java.lang.System")>
				
		<cfloop condition="TRUE">
			<cfif NOT (StructKeyExists(arguments.expected, testKey) OR StructKeyExists(arguments.actual, testKey))>
				<cfbreak/>
			</cfif>
			<cfset testKey = CreateUUID()>
		</cfloop>
		
		<cfset arguments.actual[testKey] = testKey>
		<cfset success = StructKeyExists(arguments.expected, testKey)>
		<cfset StructDelete(arguments.actual, testKey)>
		
		<cfif NOT success>
			<cftry>
				<cfset strExpected = arguments.expected.toStringValue()>
				<cfset strActual = arguments.actual.toStringValue()>
				
				<cfcatch type="any">
					<cfset strExpected = GetMetadata(arguments.expected).name & "@" & system.identityHashCode(arguments.expected)>
					<cfset strActual = GetMetadata(arguments.actual).name & "@" & system.identityHashCode(arguments.actual)>
				</cfcatch>
			</cftry>
			
			<cfset failNotSame(strExpected, strActual, arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNotSameStruct" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that two structs do not refer to the same struct. If they do an 
				AssertionFailedError is thrown with the given message.
			">
		
		<cfargument name="expected" type="struct" required="true"/>
		<cfargument name="actual" type="struct" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var testKey = CreateUUID()>
		<cfset var success = FALSE>
		
		<cfloop condition="TRUE">
			<cfif NOT (StructKeyExists(arguments.expected, testKey) OR StructKeyExists(arguments.actual, testKey))>
				<cfbreak/>
			</cfif>
			<cfset testKey = CreateUUID()>
		</cfloop>
		
		<cfset arguments.actual[testKey] = testKey>
		<cfset success = NOT StructKeyExists(arguments.expected, testKey)>
		<cfset StructDelete(arguments.actual, testKey)>
		
		<cfif NOT success>
			<cfset failSame(arguments.failureMessage)>
		</cfif>		
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNotSameComponent" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that two components do not refer to the same object. If they do an 
				AssertionFailedError is thrown with the given message.
			">
		
		<cfargument name="expected" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="actual" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		<!--- --->
		<cfset var testKey = CreateUUID()>
		<cfset var success = FALSE>
		
		<cfloop condition="TRUE">
			<cfif NOT (StructKeyExists(arguments.expected, testKey) OR StructKeyExists(arguments.actual, testKey))>
				<cfbreak/>
			</cfif>
			<cfset testKey = CreateUUID()>
		</cfloop>
		
		<cfset arguments.actual[testKey] = testKey>
		<cfset success = NOT StructKeyExists(arguments.expected, testKey)>
		<cfset StructDelete(arguments.actual, testKey)>
		
		<cfif NOT success>
			<cfset failSame(arguments.failureMessage)>
		</cfif>		
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<!--- NO TEST YET
	<cffunction name="assertSameComplex" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="Asserts that two complex variables refer to the same object. If they are not an AssertionFailedError is thrown with the given message.">
		
		<cfargument name="expected" type="any" required="true"/>
		<cfargument name="actual" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
	</cffunction>
	--->
	
	
	

	<!----------------------------------------------------------------------------------------------->
	<!--- C O N T A I N M E N T   A S S E R T I O N S --->
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertContainsString" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		hint="
				Asserts that one string contains one or more instances of the specified
				searchString. If the seachString cannot be found, AssertionFailedError
				is thrown.
			">
	
		<cfargument name="string" type="string" required="true" hint=""/>
		<cfargument name="searchString" type="string" required="true" hint=""/>
		<cfargument name="failureMessage" type="string" required="false" default="" hint=""/>
		
		<cfif NOT Find(arguments.searchString, arguments.string, 1)>
			<cfset fail(arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertArrayContainsString" returntype="void" access="public" output="false" 
		throws="AssertionFailedError"
		hint="">
		
		<cfargument name="array" type="array" required="true" hint=""/>
		<cfargument name="value" type="string" required="true" hint=""/>
		<cfargument name="failureMessage" type="string" required="false" default="" hint=""/>
		<!--- --->
		<cfset var i = 0>
	
		<cfloop index="i" from="1" to="#ArrayLen(arguments.array)#">
			<cfif NOT Compare(arguments.array[i], arguments.value)>
				<cfreturn/>
			</cfif>
		</cfloop>
		
		<cfset fail(arguments.failureMessage)>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertArrayContainsNumber" returntype="void" access="public" output="false" 
		throws="AssertionFailedError"
		hint="">
		
		<cfargument name="array" type="array" required="true" hint=""/>
		<cfargument name="value" type="numeric" required="true" hint=""/>
		<cfargument name="failureMessage" type="string" required="false" default="" hint=""/>
		<!--- --->
		<cfset var number = Val(arguments.value)>
		<cfset var message = arguments.failureMessage>
		<cfset var i = 0>
 
 		<cfloop index="i" from="1" to="#ArrayLen(arguments.array)#">
			<cfif Val(arguments.array[i]) IS number>
				<cfreturn/>
			</cfif>
		</cfloop>
		
		<cfif NOT Len(message)>
			<cfset message = "Number (#number#) is not in array.">
		</cfif>
		
		<cfset fail(message)>
 	</cffunction>




	<!----------------------------------------------------------------------------------------------->
	<!--- S T R I N G   A S S E R T I O N S --->
	<!---------------------------------------------------------------------------->

	<cffunction name="assertRegexMatch" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		since="1.0"
		hint="">
	
		<cfargument name="regex" type="string" required="true" hint=""/>
		<cfargument name="string" type="string" required="true" hint=""/>
		<cfargument name="failureMessage" type="string" required="false" default="" hint=""/>
		<!--- --->
		<cfset var message = arguments.failureMessage>
		<cfset var result = 0>
		
		<cfset result = REFind(arguments.regex, arguments.string, 1, false)>
		
		<cfif result LT 1>
			<cfif NOT Len(message)>
				<cfset message = "assertRegexMatch: Regular expression, '#arguments.regex#' does not match string.">
			</cfif>
			
			<cfset fail(message)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNotRegexMatch" returntype="void" access="public" output="false"
		throws="AssertionFailedError"
		since="1.0"
		hint="">
		
		<cfargument name="regex" type="string" required="true" hint=""/>
		<cfargument name="string" type="string" required="true" hint=""/>
		<cfargument name="failureMessage" type="string" required="false" default="" hint=""/>
		<!--- --->
		<cfset var message = arguments.failureMessage>
		<cfset var result = 0>
		
		<cfset result = REFind(arguments.regex, arguments.string, 1, false)>
		
		<cfif result GT 0>
			<cfif NOT Len(message)>
				<cfset message = "assertNotRegexMatch: Regular expression, '#arguments.regex#' matches string.">
			</cfif>
			
			<cfset fail(message)>
		</cfif>
	</cffunction>
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- N U L L   A S S E R T I O N S --->
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNull" returntype="void" access="public" output="false">
		<cfargument name="value" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif IsSimpleValue(arguments.value)>
			<cfif arguments.value NEQ NULL>
				<cfset fail(arguments.failureMessage)>
			</cfif>
		<cfelseif IsCFC(arguments.value)>
			<cfset assertNullComponent(arguments.value, arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNullComponent" returntype="void" access="public" output="false">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cftry>
			<!--- Make sure that component is Null --->
			<cfif NOT arguments.object.isNull()>
				<cfset fail(arguments.failureMessage)>
			</cfif>
			
			<cfcatch type="coldfusion.runtime.TemplateProxy$InvalidMethodNameException">
				<!--- This object does not have the 'isNull()' method. It cannot be Null. --->
				<cfset fail(arguments.failureMessage)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNotNull" returntype="void" access="public" output="false">
		<cfargument name="value" type="any" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cfif IsSimpleValue(arguments.value)>
			<cfif arguments.value IS NULL>
				<cfset fail(arguments.failureMessage)>
			</cfif>
		<cfelseif IsCFC(arguments.value)>
			<cfset assertNotNullComponent(arguments.value, arguments.failureMessage)>
		</cfif>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="assertNotNullComponent" returntype="void" access="public" output="false">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="failureMessage" type="string" required="false" default=""/>
		
		<cftry>
			<cfif arguments.object.isNull()>
				<cfset fail(arguments.failureMessage)>
			</cfif>
			
			<cfcatch type="coldfusion.runtime.TemplateProxy$InvalidMethodNameException">
				<!--- 'isNull()' method is not defined on object. --->
			</cfcatch>
		</cftry>
	</cffunction>
	
	
	
	
	<!----------------------------------------------------------------------------------------------->
	<!--- F A I L U R E   M E T H O D S --->
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="fail" returntype="void" access="public" output="false" hint="Fails a test with the given message.">
		<cfargument name="message" type="string" required="false" default=""/>
		
		<cfthrow type="AssertionFailedError" message="#arguments.message#"/>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="failSame" returntype="void" access="private" output="false">
		<cfargument name="message" type="string" required="true"/>
		<!--- --->
		<cfset var formatted = NULL>
		
		<cfif Len(arguments.message)>
			<cfset formatted = arguments.message & " ">
		</cfif>
		<cfset fail(formatted & "expected not same")>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="failNotSame" returntype="void" access="private" output="false">
		<cfargument name="expected" type="string" required="true"/>
		<cfargument name="actual" type="string" required="true"/>
		<cfargument name="message" type="string" required="false" default=""/>
		<!--- --->
		<cfset var formatted = "">
		
		<cfif Len(arguments.message)>
			<cfset formatted = arguments.message & " ">
		</cfif>
		
		<cfset fail(formatted & "expected same:<#arguments.expected#> was not:<#arguments.actual#>")>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
	<cffunction name="failNotEquals" returntype="void" access="private" output="false">
		<cfargument name="expected" type="string" required="true"/>
		<cfargument name="actual" type="string" required="true"/>
		<cfargument name="message" type="string" required="false" default=""/>
				
		<cfset fail(format(arguments.message, arguments.expected, arguments.actual))>
	</cffunction>
	
	<!-------------------------------------------------------------------------------->
	
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
	
	<!----------------------------------------------------------------------------------------------->

	<!---
	 * Returns a boolean for whether a CF variable is a CFC instance.
	 * 
	 * @param objectToCheck 	 The object to check. (Required)
	 * @return Returns a boolean. 
	 * @author Nathan Dintenfass (nathan@changemedia.com) 
	 * @version 1, October 16, 2002 
	--->
	<cffunction  name="isCFC" returntype="boolean" access="private" output="false">
		<cfargument name="objectToCheck" type="any" required="true"/>
		
		<!--- get the meta data of the object we're inspecting --->
		<cfset var metaData = getMetaData(arguments.objectToCheck)>
		
		<!--- if it's an object, let's try getting the meta Data --->
		<cfif isObject(arguments.objectToCheck)>
			<!--- if it has a type, and that type is "component", then it's a component --->
			<cfif structKeyExists(metaData,"type") AND metaData.type is "component">
				<cfreturn TRUE/>
			</cfif>
		</cfif>	
		
		<!--- if we've gotten here, it must not have been a contentObject --->
		<cfreturn FALSE/>
	</cffunction>

	<!-------------------------------------------------------------------------------->
	
</cfcomponent>