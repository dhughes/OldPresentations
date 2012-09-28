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

<cfcomponent extends="org.cfcunit.runner.TestCollector" displayname="ClassPathTestCollector" output="false" 
	hint="
			An implementation of a TestCollector that consults the class path. It considers all classes 
			on the class path. It leaves it up to subclasses to decide whether a class is a runnable 
			Test.
		">

	<!------------------------------------------------------------------------------->

	<!--- <cfproperty name="fRuntimeService" displayname="private" type="coldfusion.server.ServerFactory.RuntimeService"/> --->
	<cfproperty name="fRuntimeService" type="RuntimeService"/>
	<cfproperty name="fLoader" displayname="protected" type="org.cfcunit.runner.ComponentLoader"/>
	<cfproperty name="fClassPaths" displayname="protected" type="array"/>
	<cfproperty name="SUFFIX_LENGTH" displayname="protected" type="numeric" default="3"/>

	<!------------------------------------------------------------------------------->
	
	<cfset variables.SUFFIX_LENGTH = Len("cfc")>
	
	<cfset variables.fRuntimeService = NULL>
	<cfset variables.fLoader = NULL>
	<cfset variables.fClassPaths = NULL>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="ClassPathTestCollector" access="public" output="false" hint="Constructs a ClassPathCollector object.">
		<cfargument name="classPath" type="string" required="true" hint="List of searchable file paths."/>
		
		<!--- <cfset variables.fRuntimeService = newJavaObject("coldfusion.server.ServiceFactory").RuntimeService> --->
		<cfset variables.fRuntimeService = newObject("org.cfcunit.runner.RuntimeService").init()>
		<cfset variables.fLoader = newObject("org.cfcunit.runner.ComponentLoader").init()>
		<cfset variables.fClassPaths = ListToArray(arguments.classPath, pathSeparator)>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="classNameFromFile" returntype="string" access="private" output="false" 
		throws="Exception"
		hint="Returns the fully qualified name of a class based on its filename. convert /a/b.cfc to a.b">
		
		<cfargument name="classFileName" type="string" required="true"/>
		<!--- --->
		<cfset var componentName = NULL>
		
		<cftry>
			<cfset componentName = variables.fLoader.componentNameFromFile(arguments.classFileName)>
	
			<cfcatch type="Exception">
				<cfrethrow/>
			</cfcatch>
		</cftry>
		
		<cfreturn componentName/>		
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="collectFilesInPath" returntype="struct" access="public" output="false">
		<cfargument name="classPath" type="string" required="true"/>
		<!--- --->
		<cfset var ret = gatherFiles(arguments.classPath)>
		
		<cfreturn ret/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="collectFilesInRoots" returntype="struct" access="private" output="false">
		<cfargument name="roots" type="array" required="true"/>
		<!--- --->
		<cfset var i = 0>
		<cfset var ret = StructNew()>
		
		<cfloop index="i" from="1" to="#ArrayLen(arguments.roots)#">
			<cfset StructAppend(ret, gatherFiles(arguments.roots[i]))>
		</cfloop>
		
		<cfreturn ret/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="collectTests" returntype="array" access="public" output="false" hint="Returns an array of Strings with qualified class names.">
		<cfset var fileNames = NULL>
		<cfset var key = NULL>
		<cfset var ret = ArrayNew(1)>

		<cfset fileNames = collectFilesInRoots(variables.fClassPaths)>
		
		<cfloop collection="#fileNames#" item="key">
			<cfif isTestClass(fileNames[key])>
				<cfset ArrayAppend(ret, fileNames[key])>
			</cfif>
		</cfloop>

		<cfreturn ret/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="isTestClass" returntype="boolean" access="private" output="false">
		<cfargument name="classFileName" type="string" required="true"/>
		<!--- --->
		<cfset var fileName = getFileFromPath(arguments.classFileName)>
		
		<cfif Right(fileName, 4) IS ".cfc" AND Find("Test", fileName, 1) GT 1>
			<cfreturn TRUE/>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="splitClassPath" returntype="array" access="private" output="false">
		<cfargument name="classPath" type="string" required="true"/>
		<cfreturn ListToArray(arguments.classPath, ";")/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="gatherFiles" returntype="struct" access="private" output="false">
		<cfargument name="rootDirectory" type="string" required="true"/>
		<!--- --->
		<cfset var qDir = NULL>
		<cfset var subDir = NULL>
		<cfset var fullPath = NULL>
		<cfset var ret = StructNew()>
		
		<cfdirectory name="qDir" action="list" directory="#arguments.rootDirectory#"/>
		
		<cfloop query="qDir">
			<cfset fullPath = arguments.rootDirectory & dirDelim & qDir.Name>
			
			<cfif qDir.Type IS "dir" AND NOT Find(qDir.Name, ".")>
				<cfset subDir = getComponentsInDirectory(fullPath)>
				<cfset StructAppend(ret, subDir)>
			<cfelseif Right(qDir.Name, 4) IS ".cfc">
				<cfset ret[fullPath] = fullPath>
			</cfif>
		</cfloop>
		
		<cfreturn ret/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
</cfcomponent>