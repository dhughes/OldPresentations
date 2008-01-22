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

<cfcomponent extends="org.cfcunit.Object" displayname="TestCaseClassLoader" output="false" 
	hint="
			<p>
				A custom class loader which enables the reloading of classes for each test run. 
				The class loader can be configured with a list of package paths that should be 
				excluded from loading. The loading of these packages is delegated to the system 
				class loader. They will be shared across test runs. 
			</p>
			<p>
				The list of excluded package paths is specified in a properties file 'excluded.properties' 
				that is located in the same place as the TestCaseClassLoader class.
			</p>
		">

	<!-------------------------------------------------------------------------------------------->
	
	<cfproperty name="defaultExclusions" displayname="private" type="array"/>
	<cfproperty name="EXCLUDED_FILE" displayname="private" type="string" default="excluded.properties"/>
	<cfproperty name="fExcluded" displayname="private" type="struct"/>
	<cfproperty name="fPathItems" displayname="private" type="array"/>
	
	<!-------------------------------------------------------------------------------------------->
	
	<cfset variables.defaultExclusions = ArrayNew(1)>
	<cfset variables.EXCLUDED_FILE = "excluded.properties">
	<cfset variables.fExcluded = StructNew()>
	<cfset variables.fPathItems = ArrayNew(1)>
	
	<!-------------------------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="TestCaseClassLoader" access="public" output="false" hint="Constructs a TestCaseLoader.">
		<cfargument name="classPath" type="string" required="false"/>
		
		<cfif StructKeyExists(arguments, "classPath") AND Len(arguments.classPath)>
			<cfset variables.fPathItems = ListToArray(arguments.classPath, ";")>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------------------------------------->
	
	<cffunction name="isExcluded" returntype="boolean" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfif StructKeyExists(variables.fExcluded, arguments.string)>
			<cfreturn TRUE/>
		</cfif>
		<cfreturn FALSE/>
	</cffunction>
	
	<!-------------------------------------------------------------------------------------------->
	
	<cffunction name="loadClass" returntype="any" access="public" output="false" hint="Loads the class with the specified name.">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="resolve" type="boolean" required="false"/>
	</cffunction>
	
	<!-------------------------------------------------------------------------------------------->

</cfcomponent>