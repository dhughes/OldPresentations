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

<cfcomponent displayname="TestSuite" extends="org.cfcunit.framework.Test" output="false" 
	hint="
<p>
	A TestSuite is a Composite of Tests. It runs a collection of test cases. Here 
	is an example using the dynamic test definition.
</p>

<code>
<blockquote>
<pre>
suite = CreateObject('component', 'TestSuite');
suite.addTest(CreateObject('component', 'MathTest').init('testAdd'));
suite.addTest(CreateObject('component', 'MathTest').init('testDivideByZero'));
</pre>
</blockquote>
</code>

<p>
	Alternatively, a TestSuite can extract the tests to be run automatically. To 
	do so you pass a TestCase component to the TestSuite constructor.
</p>

<code>
<blockquote>
<pre>
mathTest = CreateObject('component', 'MathTest');
suite = CreateObject('component', 'TestSuite').init(mathTest);
</pre>
</blockquote>
</code>

<p>
	This constructor creates a suite with all the methods starting with 
	'test' that take no arguments.
</p>
 		">

	<!------------------------------------------------------------------->
	
	<cfproperty name="fName" displayname="private" type="string"/>
	<cfproperty name="fTests" displayname="private" type="array"/>
	
	<!------------------------------------------------------------------->
	
	<cfset variables.fName = NULL>
	<cfset variables.fTests = ArrayNew(1)>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestSuite" access="public" output="false" hint="Constructs a TestSuite from the given class with the given name.">
		<cfargument name="name" type="string" required="false"/>
		<cfargument name="testClass" type="WEB-INF.cftags.component" required="false"/>
		
		<cfset variables.fTests = ArrayNew(1)>
		
		<cfif StructKeyExists(arguments, "name")>
			<cfset constructWithName(arguments.name)>
		</cfif>
		<cfif StructKeyExists(arguments, "testClass")>
			<cfset constructWithTestClass(arguments.testClass)>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="constructWithName" returntype="void" access="private" output="false" hint="Constructs an empty TestSuite.">
		<cfargument name="name" type="string" required="true"/>
		<cfset setName(arguments.name)>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="constructWithTestClass" returntype="void" access="private" output="false" 
		hint="Constructs a TestSuite from the given class. Adds all the methods starting with 'test' as test cases to the suite.">
		
		<cfargument name="testClass" type="WEB-INF.cftags.component" required="false"/>
		<!--- --->
		<cfset var names = StructNew()>
		<cfset var key = NULL>
		<cfset var metadata = NULL>
		<cfset var testClassName = NULL>
		<cfset var i = 0>	
		<cfset var methods = NULL>	
		
		<cftry>
			<cfset metadata = arguments.testClass.getCFCMetadata()>
			
			<cfcatch type="coldfusion.runtime.TemplateProxy$InvalidMethodNameException">
				<cfset metadata = GetMetadata(arguments.testClass)>
			</cfcatch>
		</cftry>
		
		<cfset testClassName = metadata.Name>
		
		<cftry>
			<cfset getTestConstructor(arguments.testClass)>
			
			<cfcatch type="Exception.NoSuchMethod">
				<cfset addTest(warning("Class #testClassName# has no public constructor init(string name) or init()"))>
				<cfreturn/>
			</cfcatch>
		</cftry>
		
		<cfloop condition="TRUE">
			<cfset methods = metadata.functions>
			
			<cfloop index="i" from="1" to="#ArrayLen(methods)#">
				<cfset addTestMethod(methods[i], names, arguments.testClass)>
			</cfloop>
			
			<cfif metadata.Name IS "org.cfcunit.framework.TestCase">
				<cfbreak/>
			<cfelseif StructKeyExists(metadata, "extends") AND StructKeyExists(metadata.extends, "functions")>
				<cfset metadata = metadata.extends>
			<cfelse>
				<cfbreak/>
			</cfif>
		</cfloop>
		
		<!---
		<cfloop collection="#this#" item="key">
			<cfif IsCustomFunction(this[key])>
				<cfset addTestMethod(this[key], names, arguments.testClass)>
			</cfif>
		</cfloop>
		--->
		
		<cfif ArrayLen(variables.fTests) IS 0>
			<!--- ---
			<cfthrow type="asd" message="#testClassName#"/>
			!--- --->
			<cfset addTest(warning("No tests found in #testClassName#"))>
		</cfif>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="getTestConstructor" returntype="any" access="public" output="false"
		hint="Gets metadata for a constructor which takes a single String as its argument or a no arg constructor." 
		throws="Exception.NoSuchMethod">
		
		<cfargument name="theClass" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		<cfset var metadata = NULL>
		<cfset var methods = NULL>
		<cfset var method = NULL>
		<cfset var i = 0>
		
		<cftry>
			<cfset metadata = arguments.theClass.getCFCMetadata()>
			
			<cfcatch type="coldfusion.runtime.TemplateProxy$InvalidMethodNameException">
				<cfset metadata = GetMetadata(arguments.theClass)>
			</cfcatch>
		</cftry>
		
		<cfloop condition="TRUE">
			<cfif StructKeyExists(metadata, "functions")>
				<cfset methods = metadata.functions>

				<cfloop index="i" from="1" to="#ArrayLen(methods)#">
					<cfset method = methods[i]>
					<cfif method.Name IS "init">
						<cfif ArrayLen(method.Parameters) LTE 1>
							<cfreturn method/>
						<cfelse>
							<cfthrow type="Exception.NoSuchMethod"/>
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(metadata, "extends")>
				<cfset metadata = metadata.extends>
			<cfelse>
				<cfbreak/>
			</cfif>
		</cfloop>
		
		<cfthrow type="Exception.NoSuchMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="isTestMethod" returntype="boolean" access="private" output="false">
		<cfargument name="method" type="any" required="true" hint="Method metadata struct">
		<!--- --->
		<cfset var param = NULL>
		<cfset var i = 0>
						
		<cfif Left(arguments.method.name, 4) IS "test" AND StructKeyExists(arguments.method, "returntype") AND arguments.method.returntype IS "void">
			<cfif NOT ArrayLen(arguments.method.parameters)>
				<cfreturn TRUE/>
			<cfelse>
				<cfloop index="i" from="1" to="#ArrayLen(arguments.method.parameters)#">
					<cfset param = arguments.method.parameters[i]>
					<cfif param.required IS TRUE>
						<cfreturn FALSE/>
					</cfif>
				</cfloop>
				<cfreturn TRUE/>
			</cfif>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="isPublicTestMethod" returntype="boolean" access="private" output="false" hint="Tests that specified method is public, starts with 'test' and has no parameters.">
		<cfargument name="method" type="any" required="true" hint="Method metadata struct"/>

		<cfparam name="arguments.method.access" type="string" default="public"/>
		
		<cfif isTestMethod(arguments.method) AND arguments.method.access IS "public">
			<cfreturn TRUE/>
		</cfif>
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="getName" returntype="string" access="public" output="false" hint="Returns the name of the suite.">
		<cfreturn variables.fName/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="setName" returntype="void" access="public" output="false" hint="Sets the name of the suite.">
		<cfargument name="Name" type="string" required="true"/>
		
		<cfset variables.fName = arguments.Name>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="addTest" returntype="void" access="public" output="false" hint="Adds a test to the suite.">
		<cfargument name="test" type="Test" required="true"/>
		
		<cfset ArrayAppend(variables.fTests, arguments.test)>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="addTestSuite" returntype="void" access="public" output="false" hint="Adds the tests from the given class to the suite.">
		<cfargument name="testClass" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		<cfset var suite = newObject("org.cfcunit.framework.TestSuite").init()>

		<cfset addTest(suite.init(testClass=arguments.testClass))>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="addTestMethod" returntype="void" access="private" output="false" hint="Adds the tests from the given class to the suite.">
		<cfargument name="method" type="any" required="true" hint="Method metadata struct."/>
		<cfargument name="names" type="struct" required="true" hint="Struct of processed method names."/>
		<cfargument name="theClass" type="WEB-INF.cftags.component" required="true"/>
						
		<cfif StructKeyExists(arguments.names, arguments.method.Name)>
			<cfreturn/>
		</cfif>
		
		<cfif NOT isPublicTestMethod(arguments.method)>
			<cfif isTestMethod(arguments.method)>
				<cfset addTest(warning("Test method isn't public: #arguments.method.Name#"))>
			</cfif>
			<cfreturn/>
		</cfif>
		
		<cfset arguments.names[arguments.method.name] = arguments.method.name>
		<cfset addTest(createTest(getMetadata(arguments.theClass).name, arguments.method.name))>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="createTest" returntype="org.cfcunit.framework.Test" access="public" output="false">
		<cfargument name="testClassName" type="string" required="true"/>
		<cfargument name="name" type="string" required="true"/>
		<!--- --->
		<cfset var constructor = NULL>
		<cfset var metadata = NULL>
		<cfset var test = NULL>

		<cfset test = newObject(arguments.testClassName)>
				
		<cftry>
			<cfset constructor = getTestConstructor(test)>
		
			<cfcatch type="Exception.NoSuchMethod">
				<cfset test = warning("Class #getMetadata(test).Name# has no public constructor init(string name) or init()")>
				<cfreturn test/>
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfif ArrayLen(constructor.Parameters) IS 0>
				<cfset test.init()>
				<cfif isCFCType(test, "TestCase")>
					<cfset test.setName(arguments.name)>
				</cfif>
			<cfelse>
				<cfset test.init(arguments.name)>
			</cfif>
			
			<cfcatch type="any">
				<cfset test = warning("Cannot instanciate test case: #arguments.name# (#exceptionToString(cfcatch)#)")>
			</cfcatch>
		</cftry>
		
		<cfreturn test/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false" hint="Counts the number of test cases that will be run by this test.">
		<cfset var i = 0>
		<cfset var aTests = tests()>
		<cfset var test = NULL>
		<cfset var count = 0>
				
		<cfloop index="i" from="1" to="#ArrayLen(aTests)#">
			<cfset test = aTests[i]>
			<cfset count = count + test.countTestCases()>
		</cfloop>
		
		<cfreturn count/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="false" hint="Runs the tests and collects their result in a TestResult.">
		<cfargument name="result" type="TestResult" required="true"/>
		<!--- --->
		<cfset var i = 0>
		<cfset var test = NULL>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fTests)#">
			<cfif arguments.result.shouldStop()>
				<cfbreak/>
			</cfif>
			
			<cfset test = variables.fTests[i]>
			<cfset runTest(test, arguments.result)>
		</cfloop>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="public" output="false">
		<cfargument name="test" type="Test" required="true"/>
		<cfargument name="result" type="TestResult" required="true"/>
		
		<cfset arguments.test.run(arguments.result)>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="testAt" returntype="Test" access="public" output="false" hint="Returns the test at the given index.">
		<cfargument name="index" type="numeric" required="true"/>
		
		<cfreturn variables.fTests[arguments.index]/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="testCount" returntype="numeric" access="public" output="false" hint="Returns the number of tests in this suite.">
		<cfreturn ArrayLen(variables.fTests)/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="tests" returntype="array" access="public" output="false" hint="Returns the tests as an array.">
		<cfset var i = 0>
		<cfset var newArray = ArrayNew(1)>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fTests)#">
			<cftry>
				<cfset ArrayAppend(newArray, variables.fTests[i])>
				
				<cfcatch type="any">
					<!--- Undefined array element --->
				</cfcatch>
			</cftry>
		</cfloop>
		
		<cfreturn newArray/>
	</cffunction>

	<!------------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfif getName() NEQ NULL>
			<cfreturn getName()/>
		</cfif>
		<cfreturn super.toStringValue()/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="warning" returntype="org.cfcunit.framework.Test" access="private" output="false" hint="Returns a test which will fail and log a warning message.">
		<cfargument name="message" type="string" required="true"/>
		<!--- --->
		<cfset var warningTest = newObject("org.cfcunit.framework.TestCase").init("warning")>
		
		<cfset warningTest.setWarningMessage(arguments.message)>
		
		<cfreturn warningTest/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
	<cffunction name="exceptionToString" returntype="string" access="private" output="false" hint="Converts the stack trace into a string.">
		<cfargument name="exception" type="any" required="true"/>
		<cfreturn arguments.exception.StackTrace/>
	</cffunction>
	
	<!------------------------------------------------------------------->
	
</cfcomponent>