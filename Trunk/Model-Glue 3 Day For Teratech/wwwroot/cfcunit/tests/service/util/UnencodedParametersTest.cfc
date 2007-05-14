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
$Id: UnencodedParametersTest.cfc,v 1.1 2006/12/19 22:12:58 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/tests/service/util/UnencodedParametersTest.cfc,v $
--->

<cfcomponent name="UnencodedParametersTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>

	
	<cffunction name="testEmptyString" returntype="void" access="public" output="false">
		<cfset var params = createObject("component", "cfcunit.service.util.UnencodedParameters").init("")>
		<cfset var expected = "">
		<cfset var actual = params.getParameters()>
		
		<cfset assertEqualsString(expected, actual)>
	</cffunction>
		
	
	<!------------------------------------------------------------------------------------>
		

	<cffunction name="testNonEmptyString" returntype="void" access="public" output="false">
		<cfset var string = createUUID()>
		<cfset var params = createObject("component", "cfcunit.service.util.UnencodedParameters").init(string)>
		<cfset var expected = string>
		<cfset var actual = params.getParameters()>
		
		<cfset assertEqualsString(expected, actual)>
	</cffunction>
		
	
	<!------------------------------------------------------------------------------------>


</cfcomponent>