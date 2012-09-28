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

<cfcomponent displayname="ExceptionTestCase" extends="org.cfcunit.framework.TestCase" output="false" 
	hint="
<pre>
A TestCase that expects an Exception of class fExpected to be thrown.
The other way to check that an expected exception is thrown is:
<code>
   &lt;cftry&gt;
      &lt;cfset shouldThrow()&gt;
	
      &lt;cfcatch type='Exception.Special'&gt;
         &lt;cfreturn/&gt;
      &lt;/cfcatch&gt;
   &lt;/cftry&gt;
   &lt;cfset fail('Expected Exception.Special')&gt;
</code>
To use ExceptionTestCase, create a TestCase like:
	<code>
   &lt;cfset testCase = newObject('cfcunit.cfc.extensions.ExceptionTestCase')&gt;
   &lt;cfset testCase.init('testShouldThrow', 'Exception.Special')&gt;
   </code>
</pre>
		">

	<!-------------------------------------------------------------->
	
	<cfproperty name="expected" type="string" default=""/>
	
	<cfset variables["expected"] = NULL>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="init" returntype="ExceptionTestCase" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="exception" type="string" required="true"/>
		
		<cfset super.init(arguments.name)>
		<cfset variables.expected = arguments.exception>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="private" output="false" throws="Exception"
		hint="
				Execute the test method expecting that an Exception of the type specified 
				by the 'expected' property or one of its subtypes will be thrown.
			">

		<cftry>
			<cfset super.runTest()>
			
			<cfcatch type="any">
				<cfif cfcatch.type IS variables.expected>
					<cfreturn/>
				<cfelse>
					<cfrethrow/>
				</cfif>
			</cfcatch>
		</cftry>
		
		<cfset fail("Expected exception '#variables.expected#'")>
	</cffunction>
	
	<!-------------------------------------------------------------->

</cfcomponent>