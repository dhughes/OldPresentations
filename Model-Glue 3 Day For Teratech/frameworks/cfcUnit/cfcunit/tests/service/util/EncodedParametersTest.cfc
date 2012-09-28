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
$Id: EncodedParametersTest.cfc,v 1.2 2006/12/16 09:54:59 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/tests/service/util/EncodedParametersTest.cfc,v $
--->

<cfcomponent name="EncodedParametersTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>

	
	<cfproperty name="parameters" type="cfcunit.service.util.EncodedParameters"/>


	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
	</cffunction>
	
	<cffunction name="tearDown" returntype="void" access="private" output="false">
	</cffunction>

	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testParseEmptyParameterString" returntype="void" access="public" output="false">
		<cfset var paramString = "">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "Empty string should yield an empty structure.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testParseSingleParamWithoutValue" returntype="void" access="public" output="false">
		<cfset var paramString = "123">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = arrayNew(1)>
		<cfset var actualParams = params.getParameters()>
		
		<cfset expectedParams[1] = "123">
		
		<cfset assertEqualsArray(expectedParams, actualParams, "There should be one parameter with a value '123'.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

	
	<cffunction name="testParseSingleParameter" returntype="void" access="public" output="false">
		<cfset var paramString = "one:123">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>
		
		<cfset expectedParams["one"] = "123">
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "There should be a single property named 'one' with value '123'.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testParseTwoParameters" returntype="void" access="public" output="false">
		<cfset var paramString = "one:123;two:789">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>
		
		<cfset expectedParams["one"] = "123">
		<cfset expectedParams["two"] = "789">
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "There should be a two properties.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testParseUnnamedParameters" returntype="void" access="public" output="false">
		<cfset var paramString = "123,789">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = arrayNew(1)>
		<cfset var actualParams = params.getParameters()>
		
		<cfset expectedParams[1] = "123">
		<cfset expectedParams[2] = "789">
		
		<!---
		<cfdump var="#paramString#"/>
		<cfdump var="#expectedParams#"/>
		<cfdump var="#actualParams#"/>
		<cfabort/>
		--->
		
		<cfset assertEqualsArray(expectedParams, actualParams, "There should be two unnamed parameters.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testParseNullParameter" returntype="void" access="public" output="false">
		<cfset var paramString = "abc:123;def;xyz:789">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>

		<cfset expectedParams["abc"] = "123">
		<cfset expectedParams["def"] = "">
		<cfset expectedParams["xyz"] = "789">
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "There should be three parameters. 'def' should be empty.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testParseEmptyStringParameter" returntype="void" access="public" output="false">
		<cfset var paramString = "abc:123;def:;xyz:789">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>

		<cfset expectedParams["abc"] = "123">
		<cfset expectedParams["def"] = "">
		<cfset expectedParams["xyz"] = "789">
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "There should be three parameters. 'def' should be empty string.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="testParseFirstParameterNull" returntype="void" access="public" output="false">
		<cfset var paramString = "abc;def:456;xyz:789">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>

		<cfset expectedParams["abc"] = "">
		<cfset expectedParams["def"] = "456">
		<cfset expectedParams["xyz"] = "789">
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "There should be three parameters. 'abc' should be empty.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="testParseLastParameterNull" returntype="void" access="public" output="false">
		<cfset var paramString = "abc:123;def:456;xyz">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = structNew()>
		<cfset var actualParams = params.getParameters()>

		<cfset expectedParams["abc"] = "123">
		<cfset expectedParams["def"] = "456">
		<cfset expectedParams["xyz"] = "">
		
		<cfset assertEqualsStruct(expectedParams, actualParams, "There should be three parameters. 'xyz' should be empty.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testMixedParameters" returntype="void" access="public" output="false">
		<cfset var paramString = "pabc,one:two">
		<cfset var params = newEncodedParameters(paramString)>
		<cfset var expectedParams = arrayNew(1)>
		<cfset var actualParams = params.getParameters()>
		
		<cfset expectedParams[1] = "pabc">
		<cfset expectedParams[2] = "one:two">
		
		<!---
		<cfdump var="#paramString#"/>
		<cfdump var="#expectedParams#"/>
		<cfdump var="#actualParams#"/>
		<cfabort/>
		--->
		
		<cfset assertEqualsArray(expectedParams, actualParams, "There should be two ordered parameters.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newEncodedParameters" returntype="cfcunit.service.util.EncodedParameters" access="private" output="false">
		<cfargument name="parameters" type="string" required="false"/>
		
		<cfreturn newObject("cfcunit.service.util.EncodedParameters").init(argumentCollection=arguments)/>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>

</cfcomponent>