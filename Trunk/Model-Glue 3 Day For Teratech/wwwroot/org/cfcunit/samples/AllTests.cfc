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

<cfcomponent name="AllTests" extends="org.cfcunit.Object" output="false" hint="Runs all unit tests in package.">

	<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false" hint="">
		<cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init("All cfcUnit Tests")>

		<cfset testSuite.addTestSuite(newObject("org.cfcunit.samples.ArrayTest"))>
		<cfset testSuite.addTestSuite(newObject("org.cfcunit.samples.money.MoneyTest"))>
		<cfset testSuite.addTest(newObject("org.cfcunit.tests.AllTests").suite())>
		
		<cfreturn testSuite/>
	</cffunction>	

</cfcomponent>