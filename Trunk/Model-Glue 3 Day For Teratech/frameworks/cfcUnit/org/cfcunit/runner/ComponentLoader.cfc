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

<cfcomponent displayname="ComponentLoader" extends="org.cfcunit.Object" output="false" hint="">

	<!------------------------------------------------------------------------------->
	
	<!--- <cfproperty name="fRuntimeService" displayname="private" type="coldfusion.server.ServerFactory.RuntimeService"/> --->
	<cfproperty name="fRuntimeService" type="RuntimeService"/>
	<cfproperty name="fPathItems" displayname="private" type="array"/>
	<cfproperty name="fMetadata" displayname="protected" type="struct"/>
	<cfproperty name="dirDelim" displayname="protected" type="string" default="\"/>
	<cfproperty name="pathSeparator" displayname="protected" type="string" default=";"/>
	
	<!------------------------------------------------------------------------------->
	
	<cfset variables.fRuntimeService = NULL>
	<cfset variables.fPathItems = NULL>
	<cfset variables.fMetadata = NULL>
	
	<cfset dirDelim = Right(ExpandPath("./"), 1)>
	<cfset pathSeparator = ";">
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="ComponentLoader" access="public" output="false">
		<cfargument name="classPath" type="string" required="false"/>
	
		<cfif StructKeyExists(arguments, "classPath")>
			<cfset variables.fPathItems = ListToArray(arguments.classPath, pathSeparator)>
		<cfelse>
			<cfset variables.fPathItems = ArrayNew(1)>
		</cfif>
		
		<!--- <cfset variables.fRuntimeService = newJavaObject("coldfusion.server.ServiceFactory").RuntimeService> --->
		<cfset variables.fRuntimeService = newObject("org.cfcunit.runner.RuntimeService").init()>
		<cfset variables.fMetadata = StructNew()>
				
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="metadataFromName" returntype="struct" access="public" output="false" hint="" throws="Exception.ComponentNotFound">
		<cfargument name="componentName" type="string" required="true"/>
		<cfargument name="resolve" type="boolean" required="false" default="FALSE"/>
		<!--- --->
		<cfset var fullName = arguments.componentName>
		<cfset var component = NULL>
		<cfset var metadata = NULL>
		
		<cfif arguments.resolve>
			<cfset fullName = resolveComponentName(fullName)>
		</cfif>
		
		<cfif StructKeyExists(variables.fMetadata, fullName)>
			<cfreturn variables.fMetadata[fullName]/>
		</cfif>
		
		<cftry>
			<cfset component = componentFromName(fullName)>
			<cfset metadata = getMetadata(component)>
			<cfset variables.fMetadata[fullName] = metadata>
			
			<cfcatch type="Exception.ComponentNotFound">
				<cfrethrow/>
			</cfcatch>
		</cftry>
		
		<cfreturn metadata/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="metadataFromFile" returntype="struct" access="public" output="false" hint="" throws="Exception.ComponentNotFound">
		<cfargument name="fileName" type="string" required="true"/>
		<!--- --->
		<cfset var componentName = NULL>
		<cfset var metadata = NULL>
		
		<cftry>
			<cfset componentName = componentNameFromFile(arguments.fileName)>
			<cfset metadata = metadataFromName(componentName)>
			
			<cfcatch type="Exception.ComponentNotFound">
				<cfrethrow/>
			</cfcatch>
		</cftry>
		
		<cfreturn metadata/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="componentFromName" returntype="WEB-INF.cftags.cfcomponent" access="public" output="false" throws="Exception.ComponentNotFound" hint="Returns an object of the specified component type.">
		<cfargument name="componentName" type="string" required="true"/>
		<cfargument name="resolve" type="boolean" required="false" default="FALSE"/>
		<!--- --->
		<cfset var fullName = arguments.componentName>
		<cfset var component = NULL>
		<cfset var message = NULL>
		
		<cfif arguments.resolve>
			<cfset fullName = resolveComponentName(fullName)>
		</cfif>
		
		<cftry>
			<cfset component = newObject(fullName)>
			
			<cfcatch type="any">
				<cfset message = "The component definition file for component '#arguments.componentName#' cannot be found on this server.">
				<cfthrow type="Exception.ComponentNoFound" message="#message#"/>
			</cfcatch>
		</cftry>
		
		<cfreturn component/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="componentFromFile" returntype="WEB-INF.cftags.cfcomponent" access="public" output="false" throws="Exception.ComponentNotFound" hint="Returns a object using the specified component file.">
		<cfargument name="fileName" type="string" required="true"/>
		<!--- --->
		<cfset var componentName = NULL>
		<cfset var component = NULL>
		
		<cftry>
			<cfset componentName = componentNameFromFile(arguments.fileName)>
			
			<cfcatch type="Exception">
				<cfthrow type="Exception.ComponentNotFound" message="#cfcatch.message#"/>
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfset component = newObject(componentName)>
			
			<cfcatch type="any">
				<cfset message = "The component definition file for component '#componentName#' cannot be found on this server.">
			</cfcatch>
		</cftry>
		
		<cfreturn component/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="componentNameFromFile" returntype="string" access="public" output="false" 
		hint="Returns the fully qualified name of a component based on its filename." 
		throws="Exception.InvalidFileName,Exception.ComponentNotFound">
		
		<cfargument name="fileName" type="string" required="true"/>
		<!---  --->
		<cfset var roots = StructNew()>
		<cfset var matchedRoot = StructNew()>
		<cfset var mappedPath = NULL>
		<cfset var errorMessage = NULL>
		<cfset var ret = NULL>
				
		<!---------------------------------------------------->
		
		<cfif NOT FileExists(arguments.fileName)>
			<cfset errorMessage = "The file '#arguments.fileName#' could not be found.">
			<cfthrow type="Exception.InvalidFileName" message="#errorMessage#"/>
		</cfif>
		
		<cfif NOT isComponentFile(arguments.fileName)>
			<cfset errorMessage = "The file '#arguments.fileName#' is not a ColdFusion component.">
			<cfthrow type="Exception.InvalidFileName" message="#errorMessage#"/>
		</cfif>
		
		<!---------------------------------------------------->
		
		<cfset roots = getComponentRoots()>
		
		<cfset matchedRoot = findMatchingRoot(roots, arguments.fileName)>
		
		<cfif Len(matchedRoot.path)>
			<cfset mappedPath = ReplaceNoCase(arguments.fileName, matchedRoot.path, matchedRoot.mapping, "one")>
			<cfset mappedPath = ListChangeDelims(mappedPath, "/", dirDelim)>
			<cfset mappedPath = ListChangeDelims(mappedPath, "/", "/")>
			<cfset mappedPath = ListDeleteAt(mappedPath, ListLen(mappedPath, "."), ".")>
			
			<cfif NOT Find(mappedPath, ".")>
				<cfreturn mappedPath/>
			</cfif>
		</cfif>
		
		<cfset errorMessage = "The file '#arguments.fileName#' cannot be resolved to a fully qualified component name.">
		<cfthrow type="Exception.ComponentNotFound" message="#errorMessage#"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="isComponentFile" returntype="boolean" access="private" output="false" hint="Determines if filename is that of a CF Component.">
		<cfargument name="fileName" type="string" required="true"/>
		
		<cfif CompareNoCase(Right(arguments.fileName, 4), ".cfc")>
			<cfreturn FALSE/>
		</cfif>
		<cfreturn TRUE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="findMatchingRoot" returntype="struct" access="private" output="false" hint="">
		<cfargument name="rootPaths" type="struct" required="true"/>
		<cfargument name="fileName" type="string" required="true"/>
		<!--- --->
		<cfset var curDir = NULL>
		<cfset var bestMatch = StructNew()>
		
		<cfset bestMatch.path = NULL>
		<cfset bestMatch.mapping = NULL>
		<cfset bestMatch.dirDepth = 0>
		
		<cfloop collection="#arguments.rootPaths#" item="curDir">
			<cfif directoryIncludes(curDir, arguments.fileName) AND ListLen(curDir, dirDelim) GT ListLen(bestMatch.dirDepth, dirDelim)>
				<cfset bestMatch.path = curDir>
				<cfset bestMatch.mapping = arguments.rootPaths[curDir]>
				<cfset bestMatch.dirDepth = ListLen(curDir, dirDelim)>
			</cfif>
		</cfloop>		
		
		<cfreturn bestMatch/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="directoryIncludes" returntype="boolean" access="private" output="false" hint="">
		<cfargument name="rootDir" type="string" required="true"/>
		<cfargument name="testDir" type="string" required="true"/>
		
		<cfif Left(arguments.testDir, Len(arguments.rootDir)) IS arguments.rootDir>
			<cfreturn TRUE/>
		</cfif>
	
		<cfreturn FALSE/>
	</cffunction>
		
	<!------------------------------------------------------------------------------->
	
	<cffunction name="getComponentRoots" returntype="struct" access="private" output="false" hint="">
		<cfset var Mappings = NULL>
		<cfset var CustomTags = NULL>
		<cfset var key = NULL>
		<cfset var Roots = StructNew()>
	
		<!---
		<cflock name="cfadmin_runtime" type="readonly" timeout="10">
			<cfset Mappings = Duplicate(variables.fRuntimeService.getMappings())>
			<cfset CustomTags = Duplicate(variables.fRuntimeService.getCustomTags())>		
		</cflock>
		--->

		<cfset Mappings = Duplicate(variables.fRuntimeService.getMappings())>
		<cfset CustomTags = Duplicate(variables.fRuntimeService.getCustomTags())>		
		
		<cfloop collection="#Mappings#" item="key">
			<cfif NOT StructKeyExists(Roots, Mappings[key])>
				<cfset Roots[Mappings[key]] = key>
			</cfif>
		</cfloop>
		
		<cfloop collection="#CustomTags#" item="key">
			<cfif NOT StructKeyExists(Roots, CustomTags[key])>
				<cfset Roots[CustomTags[key]] = NULL>
			</cfif>
		</cfloop>

		<cfreturn Roots/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="inClassPath" returntype="boolean" access="private" output="false" hint="Determines if file or directory is in the ClassPath.">
		<cfargument name="fileName" type="string" required="true"/>
		<!--- --->
		<cfset var i = 0>
		
		<cfif ArrayLen(variables.fPathItems)>
			<cfloop index="i" from="1" to="#ArrayLen(variables.fPathItems)#">
				<cfif directoryIncludes(variables.fPathItems[i], arguments.fileName)>
					<cfreturn TRUE/>
				</cfif>
			</cfloop>
			<cfreturn FALSE/>
		</cfif>
		
		<cfreturn TRUE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="resolveComponentName" returntype="string" access="private" output="false">
		<cfargument name="componentName" type="string" required="true"/>
		<!--- --->
		<cfreturn arguments.componentName/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
</cfcomponent>