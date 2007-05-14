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

<cfcomponent displayname="TestCase" extends="org.cfcunit.framework.Assert" output="false" 
	hint="
A test case defines the fixture to run multiple tests. To define a test case: 

<ol>
	<li>implement a subclass of TestCase</li>
	<li>define instance variables that store the state of the fixture</li>
	<li>initialize the fixture state by overriding setUp</li>
	<li>clean-up after a test by overriding tearDown.</li>
</ol>

<p>
	Each test runs in its own fixture so there can be no side effects among 
	test runs. Here is an example:
</p>

<code>
<blockquote>
<pre>
&lt;cfcomponent extends='TestCase'&gt;
    &lt;cfset variables.fValue1 = NULL&gt;
    &lt;cfset variables.fValue2 = NULL&gt;

    &lt;cffunction name='setUp' returntype='void' access='private' output='false'&gt;
        &lt;cfset variables.fValue1 = 2.0&gt;
        &lt;cfset variables.fValue2 = 3.0&gt;
    &lt;/cffunction&gt;
&lt;cfcomponent&gt;
</pre>
</blockquote>
</code>

<p>
	For each test implement a method which interacts with the fixture. Verify the expected 
	results with assertions specified by calling assertTrue() with a boolean value.
</p>

<code>
<blockquote>
<pre>
&lt;cffunction name='testAdd' returntype='void' access='public' output='false'&gt;
    &lt;cfset var result = variables.fValue1 + variables.fValue2&gt;
    &lt;cfset assertTrue(result IS 5.0)&gt;
&lt;/cffunction&gt;
</pre>
</blockquote>
</code>

<p>
	Once the methods are defined you can run them. The framework supports both a static type 
	safe and more dynamic way to run a test. In the static way you override the 
	'runTest()' method and define the method to be invoked. 
</p>
		">
		
	<!--------------------------------------------------------------->
	
	<cfproperty name="fName" displayname="private" type="string" hint="Name of the test case."/>
	
	<!--------------------------------------------------------------->
	
	<cfset variables.fName = NULL>
	<cfset variables.fWarningMessage = NULL>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestCase" access="public" output="false" 
		hint="Constructs a TestCase with an optional name.  If a name is not specified, this method is 
				not intended to be used by mere mortals without next calling setName().">
						
		<cfargument name="Name" type="string" required="false" default=""/>
		
		<cfset variables.fName = arguments.Name>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="createResult" returntype="TestResult" access="private" output="false" 
		hint="Creates a default TestResult object.">
		
		<cfset var ret = newObject("org.cfcunit.framework.TestResult").init()>
		<cfreturn ret/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getName" returntype="string" access="public" output="false" hint="Gets the name of a TestCase.">
		<cfreturn variables.fName/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="setName" returntype="void" access="public" output="false" hint="Sets the name of a TestCase.">
		<cfargument name="Name" type="string" required="true" hint="The name to set"/>
	
		<cfset variables.fName = arguments.Name/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="private" output="false" 
		hint="Sets up the fixture, for example, open a network connection.">
		<!--- This does nothing right now.  This should be overridden in subclasses --->
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="runBare" returntype="void" access="public" output="false" hint="Runs the bare test sequence." throws="Exception,AssertionFailedError">
		<cfset setUp()>
		
		<cftry>
			<cfset runTest()>
			
			<cfcatch type="any">
				<cfset tearDown()>
				<cfrethrow/>
			</cfcatch>
		</cftry>
		
		<cfset tearDown()>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="private" output="false" 
		hint="Override to run the test and assert its state." 
		throws="AssertionFailedError,Exception">
		
		<cfset assertNotNull(variables.fName, "Instance of '#this.getCFCMetadata().Name#' does not have a name.")>

		<cfif NOT (StructKeyExists(this, variables.fName) AND IsCustomFunction(this[variables.fName]))>
			<cfset fail("Method '#variables.fName#' not found")>
		</cfif>
		
		<cfinvoke component="#this#" method="#variables.fName#"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="tearDown" returntype="void" access="private" output="false" 
		hint="Tears down the fixture, for example, close a network connection.">
		<!--- This does nothing right now.  This should be overridden in subclasses --->
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false" 
		hint="Returns a string representation of the test case.">
		
		<cfreturn getName() & "(" & getCFCMetadata().Name & ")"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="run" returntype="TestResult" access="public" output="false" 
		hint="Runs the test case and collects the results in TestResult.">
		
		<cfargument name="result" type="TestResult" required="false"/>
		<!--- --->
		<cfset var testResult = NULL>
		
		<cfif StructKeyExists(arguments, "result")>
			<!--- Runs the test case and collects the results in TestResult. --->
			<cfset testResult = arguments.result>
			<cfset testResult.run(this)>
		<cfelse>
			<!--- A convenience method to run this test, collecting the results with a default TestResult object. --->
			<cfset testResult = createResult()>
			<cfset run(testResult)>
		</cfif>

		<cfreturn testResult/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false" 
		hint="Counts the number of test cases executed by run(TestResult result).">
		
		<cfreturn 1/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	<!--- 
		These two methods are used to create a special case of TestCase that simply throws 
		an exception to the testing environment.  See the warning() method of TestSuite.
	--->
	
	<cffunction name="setWarningMessage" returntype="void" access="package" output="false">
		<cfargument name="message" type="string" required="true"/>
		<cfset variables.fWarningMessage = arguments.message>
	</cffunction>
	
	<cffunction name="warning" returntype="void" access="public" output="false">
		<cfset fail(variables.fWarningMessage)>
	</cffunction>
		
	<!--------------------------------------------------------------->
	
</cfcomponent>