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

<cfcomponent extends="org.cfcunit.runner.ClassPathTestCollector" displayname="LoadingTestCollector" output="false" 
	hint="
			An implementation of a TestCollector that loads all classes on the class path 
			and tests whether it is assignable from Test or provides a 'suite' method.
		">
	
	<!------------------------------------------------------------------------------>
	
	<cfproperty name="fLoader" displayname="private" type="org.cfcunit.runner.TestCaseClassLoader"/>
	
	<!------------------------------------------------------------------------------>
	
	<cfset variables.fLoader = NULL>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="init" returntype="LoadingTestCollector" access="public" output="false" hint="Constructs a LoadingTestCollector object.">
		<cfargument name="classPath" type="string" required="true" hint="Semi-colon separated list of file paths."/>

		<cfset super.init(arguments.classPath)>
		<cfset variables.fLoader = newObject("org.cfcunit.runner.TestCaseClassLoader")>
				
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="classFromFile" returntype="WEB-INF.cftags.component" access="public" output="false" throws="Exception.ClassNotFound">
		<cfargument name="classFileName" type="string" required="true"/>
		<!--- --->
		<cfset var className = classNameFromFile(arguments.classFileName)>
		
		<cfif NOT Len(className)>
			<cfthrow type="Exception.ClassNotFound"/>
		</cfif>
		
		<cfreturn newObject(className)/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="hasPublicConstructor" returntype="boolean" access="private" output="false" hint="Determines if a component has a public constructor, 'init()'.">
		<cfargument name="testClass" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		<cfset var metadata = NULL>
		
		<cfif StructKeyExists(arguments.testClass, "init")>
			<cfset metadata = getMetadata(arguments.testClass.init)>
			<cfif NOT StructKeyExists(metadata, "access") OR metadata.access IS "public">
				<cfreturn TRUE/>
			</cfif>			
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="hasSuiteMethod" returntype="boolean" access="private" output="false" hint="Determines if a component defines a public 'suite()' method.">
		<cfargument name="testClass" type="WEB-INF.cftags.component" required="true"/>
		
		<cfif StructKeyExists(arguments.testClass, "suite")>
			<cfif IsCustomFunction(arguments.testClass.suite)>
				<cfreturn TRUE/>
			</cfif>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="isTestClass" returntype="boolean" access="private" output="false" hint="Determines if file is a class of subtype of 'Test' or has a public 'suite' method.">
		<cfargument name="classFileName" type="string" required="true"/>
		<!--- --->
		<cfset var object = classFromFile(arguments.classFileName)>
		
		<cfif hasSuiteMethod(object) OR super.isTestClass(arguments.classFileName)>
			<cfreturn TRUE/>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
</cfcomponent>