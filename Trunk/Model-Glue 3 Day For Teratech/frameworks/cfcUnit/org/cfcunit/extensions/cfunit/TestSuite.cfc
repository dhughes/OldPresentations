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
$Id: TestSuite.cfc,v 1.2 2006/11/21 20:49:43 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/extensions/cfunit/TestSuite.cfc,v $
--->

<cfcomponent name="TestSuite" extends="org.cfcunit.framework.TestSuite" output="false" 
	hint="
			This class acts as a wrapper for running CFUnit tests from within cfcUnit.
	">
	
	<!--------------------------------------------------------------------------------->
	
	<cfproperty name="cfUnitTestSuite" type="any" hint="net.sourceforge.cfunit.framework.TestSuite"/>
	
	<cfset variables["cfUnitTestSuite"] = NULL>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestSuite" access="public" output="false" hint="">
		<cfargument name="name" type="string" required="false"/>
		<cfargument name="testClass" type="net.sourceforge.cfunit.framework.Test" required="false"/>
		<!--- --->
		<cfset var testSuite = NULL>
		
		<cfif StructKeyExists(arguments, "testClass")>
			<cfif StructKeyExists(arguments.testClass, "suite")>
				<cfset variables.cfUnitTestSuite = arguments.testClass.suite()>
			<cfelse>
				<cfset variables.cfUnitTestSuite = arguments.testClass>
			</cfif>
		<cfelse>
			<cfset variables.cfUnitTestSuite = newObject("net.sourceforge.cfunit.framework.TestSuite").init()>
		</cfif>

		<cfif StructKeyExists(arguments, "name")>
			<cfset setName(arguments.name)>
		</cfif>

		<cfreturn this/>
	</cffunction>

	<!--------------------------------------------------------------------------------->
	
	<cffunction name="getName" returntype="string" access="public" output="false" hint="Returns the name of the suite.">
		<cfreturn variables.cfUnitTestSuite.getName()/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="setName" returntype="void" access="public" output="false" hint="Sets the name of the suite.">
		<cfargument name="name" type="string" required="true"/>
		
		<cfset variables.cfUnitTestSuite.setName(arguments.name)>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->

	<cffunction name="addTest" returntype="void" access="public" output="false" hint="This does nothing.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="addTestSuite" returntype="void" access="public" output="false" hint="This does nothing.">
		<cfargument name="testClass" type="WEB-INF.cftags.component" required="true"/>
		
		<cfset variables.cfUnitTestSuite.addTestSuite(GetMetadata(arguments.testClass).name)>
	</cffunction>

	<!--------------------------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false" hint="Counts the number of test cases that will be run by this test.">		
		<cfreturn variables.cfUnitTestSuite.countTestCases()/>
	</cffunction>

	<!--------------------------------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="false" hint="">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		<!--- --->
		<cfset var listenerProxy = newObject("org.cfcunit.extensions.cfunit.TestListenerProxy").init(cfcUnitTestResult=arguments.result)>
		<cfset var testResult = newObject("net.sourceforge.cfunit.framework.TestResult").init()>
		
		<cfset testResult.addListener(listenerProxy)>

		<cfset variables.cfUnitTestSuite.run(testResult)>
	</cffunction>

	<!--------------------------------------------------------------------------------->

	<cffunction name="runTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		
		<cfset super.runTest(arguments.test, arguments.result)>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="testAt" returntype="org.cfcunit.framework.Test" access="public" output="false" 
		hint="Returns the test at the given index.">
		
		<cfargument name="index" type="numeric" required="true"/>
		<!--- --->
		<cfset var cfUnitTest = variables.cfUnitTestSuite.testAt(arguments.index)>
		<cfset var test = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTest)>
		
		<cfreturn test/>
	</cffunction>

	<!--------------------------------------------------------------------------------->
	
	<cffunction name="testCount" returntype="numeric" access="public" output="false" 
		hint="Returns the number of tests in this suite.">
		
		<cfreturn variables.cfUnitTestSuite.testCount()/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="tests" returntype="array" access="public" output="false" hint="Returns the tests as an array.">
		<cfset var cfUnitTests = variables.cfUnitTestSuite.tests()>
		<cfset var cfUnitTest = NULL>
		<cfset var test = NULL>
		<cfset var tests = ArrayNew(1)>
		
		<cfloop condition="#cfUnitTests.hasNext()#">
			<cfset cfUnitTest = cfUnitTests.next()>
			<cfset test = newObject("org.cfcunit.extensions.cfunit.TestCase").init(cfUnitTest)>
			<cfset ArrayAppend(tests, test)>
		</cfloop>
		
		<cfreturn tests/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn variables.cfUnitTestSuite.getString()/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->
	
	<cffunction name="getTestSuite" returntype="net.sourceforge.cfunit.framework.TestSuite" access="public" output="false" hint="">
		<cfreturn variables.cfUnitTestSuite/>
	</cffunction>
	
	<!--------------------------------------------------------------------------------->

</cfcomponent>