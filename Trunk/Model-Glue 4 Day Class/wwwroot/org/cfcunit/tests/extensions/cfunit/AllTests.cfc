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
$Id: AllTests.cfc,v 1.4 2006/11/21 20:49:40 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/tests/extensions/cfunit/AllTests.cfc,v $
--->

<cfcomponent name="AllTests" extends="org.cfcunit.Object" output="false" 
	hint="
			TestSuite that runs all the CFUnit extension tests.
		">
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init("Framework Tests")>
		
		<!--- 
			This tests to make sure that the CFUnit framework is available for testing this 
			extension. If a CFUnit TestCase object cannot be instantiated, do not bother with
			these tests since they will all fail.
		--->
		<cftry>
			<cfset CreateObject("component", "net.sourceforge.cfunit.framework.TestCase")>
			
			<cfcatch type="any">
				<cfreturn testSuite/>
			</cfcatch>
		</cftry>
		
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.extensions.cfunit.TestListenerProxyTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.extensions.cfunit.TestCaseTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.tests.extensions.cfunit.TestSuiteTest"))>
		
		<cfreturn testSuite/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->

</cfcomponent>