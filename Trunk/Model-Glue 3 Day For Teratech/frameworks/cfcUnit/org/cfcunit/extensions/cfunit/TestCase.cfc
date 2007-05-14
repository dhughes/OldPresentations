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
$Id: TestCase.cfc,v 1.2 2006/11/21 20:49:43 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/extensions/cfunit/TestCase.cfc,v $
--->

<cfcomponent name="TestCase" extends="org.cfcunit.framework.TestCase" output="false" 
	hint="
			This class acts as a wrapper for CFUnit TestCase objects so that they can be
			used inside cfcUnit.
		">

	<!-------------------------------------------------------------------------->
	
	<cfproperty name="cfUnitTestCase" type="net.sourceforge.cfunit.framework.TestCase" hint=""/>
	
	<cfset variables["cfUnitTestCase"] = NULL>
	
	<!-------------------------------------------------------------------------->

	<cffunction name="init" returntype="TestCase" access="public" output="false" hint="">
		<cfargument name="cfUnitTestCase" type="net.sourceforge.cfunit.framework.TestCase" required="true" hint=""/>
		
		<cfset variables.cfUnitTestCase = arguments.cfUnitTestCase>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->

	<cffunction name="getName" returntype="string" access="public" output="false" hint="">
		<cfreturn variables.cfUnitTestCase.getName()/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->

	<cffunction name="setName" returntype="void" access="public" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="The name to set"/>

		<cfset variables.cfUnitTestCase.setName(arguments.name)>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false" hint="">
		<cfreturn variables.cfUnitTestCase.getString()/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false" hint="">
		<cfreturn variables.cfUnitTestCase.countTestCases()/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="run" returntype="org.cfcunit.framework.TestResult" access="public" output="false" hint="">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="false"/>
		<!--- --->
		<cfset var cfUnitTestResult = newObject("net.sourceforge.cfunit.framework.TestResult").init()>
		<cfset var listenerProxy = NULL>
		<cfset var testResult = NULL>
		
		<cfif NOT StructKeyExists(arguments, "result")>
			<cfset testResult = createResult()>
		<cfelse>
			<cfset testResult = arguments.result>
		</cfif>

		<cfset listenerProxy = CreateObject("component", "TestListenerProxy").init(cfcUnitTestResult=testResult)>
		<cfset cfUnitTestResult.addListener(listenerProxy)>
		
		<cfset variables.cfUnitTestCase.run(cfUnitTestResult)>
		
		<cfreturn testResult/>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="runBare" returntype="void" access="public" output="false" hint="">
		<cfset variables.cfUnitTestCase.runBare()>
	</cffunction>
	
	<!-------------------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="private" output="false" hint="">
		<cfset variables.cfUnitTestCase.runTest()>
	</cffunction>
	
	<!-------------------------------------------------------------------------->

</cfcomponent>