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

<!---
$Id: JSONEncodedParametersTest.cfc,v 1.1 2006/12/19 22:12:58 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/tests/service/util/JSONEncodedParametersTest.cfc,v $
--->

<cfcomponent name="JSONEncodedParametersTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>

	
	<cffunction name="testParseEmptyParameterString" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("")>
		<cfset var expected = "unknown:">
		<cfset var actual = params.getParameters()>
		
		<cfset assertEqualsString(expected, actual)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testParseSimpleString" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("'abc'")>
		<cfset var expected = "abc">
		<cfset var actual = params.getParameters()>
		
		<cfset assertEqualsString(expected, actual)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testSingleOrderedValue" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("['abc']")>
		<cfset var expected = listToArray("abc")>
		<cfset var actual = params.getParameters()>
		
		<cfset assertEqualsArray(expected, actual)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testMultipleOrderedValues" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("['abc','def','xyz']")>
		<cfset var expected = listToArray("abc,def,xyz")>
		<cfset var actual = params.getParameters()>
		
		<cfset assertEqualsArray(expected, actual)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testSingleNamedParameter" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("{abc:123}")>
		<cfset var expected = structNew()>
		<cfset var actual = params.getParameters()>
		
		<cfset expected["abc"] = val(123)>
		
		<cfset assertEqualsStruct(expected, actual)>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>


	<cffunction name="testMultipleNamedParameters" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("{abc:123,xyz:789}")>
		<cfset var expected = structNew()>
		<cfset var actual = params.getParameters()>
		
		<cfset expected["abc"] = val(123)>
		<cfset expected["xyz"] = val(789)>
		
		<cfset assertEqualsStruct(expected, actual)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testMixedParametersInArray" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("[{abc:123},456]")>
		<cfset var expected = arrayNew(1)>
		<cfset var actual = params.getParameters()>
		
		<cfset expected[1] = structNew()>
		<cfset expected[1]["abc"] = val(123)>
		<cfset expected[2] = val(456)>
		
		<cfset assertEqualsArray(expected, actual)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testMixedParametersInStruct" returntype="void" access="public" output="false">
		<cfset var params = newEncodedParameters("{abc:123,xyz:[1,2,3]}")>
		<cfset var expected = structNew()>
		<cfset var actual = params.getParameters()>
		
		<cfset expected["abc"] = val(123)>
		<cfset expected["xyz"] = arrayNew(1)>
		<cfset expected.xyz[1] = val(1)>
		<cfset expected.xyz[2] = val(2)>
		<cfset expected.xyz[3] = val(3)>
		
		<cfset assertEqualsStruct(expected, actual)>
	</cffunction>

	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newEncodedParameters" returntype="cfcunit.service.util.JSONEncodedParameters" access="private" output="false">
		<cfargument name="parameters" type="string" required="false"/>
		
		<cfreturn createObject("component", "cfcunit.service.util.JSONEncodedParameters").init(argumentCollection=arguments)/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


</cfcomponent>