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

<cfcomponent name="Class" extends="org.cfcunit.Object" output="false" hint="">

	<!---------------------------------------------------------------------------->
	
	<cfproperty name="metadata" type="metadata" access="private"/>
	
	<cfset variables["metadata"] = NULL>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="init" returntype="Class" access="package" output="false">
		<cfargument name="object" type="any" required="false"/>
		<cfargument name="metadata" type="any" required="false"/>
		
		<cfif StructKeyExists(arguments, "object")>
			<cfif isComponent(arguments.object)>
				<cfset variables.metadata = GetMetadata(arguments.object)>
			<cfelse>
				<cfthrow type="Exception.InvalidArgument" message="object"/>
			</cfif>	
		<cfelseif StructKeyExists(arguments, "metadata")>
			<cfif isCFCMetadata(arguments.metadata)>
				<cfset variables.metadata = arguments.metadata>
			<cfelse>
				<cfthrow type="Exception.InvalidArgument" message="metadata"/>
			</cfif>
		</cfif>
				
		<cfreturn this/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="forName" returntype="org.cfcunit.Object" access="public" output="false" 
		throws="Exception.ClassNotFound" hint="">
		
		<cfargument name="className" type="string" required="true"/>
		<!--- --->
		<cfset var obj = NULL>
		<cfset var class = NULL>
		
		<cftry>
			<cfset obj = newObject(arguments.className)>
			
			<cfcatch type="any">
				<cfthrow type="Exception.ClassNotFound" message="#arguments.className#"/>
			</cfcatch>			
		</cftry>
		
		<cfset class = newObject("org.cfcunit.lang.Class")>
		<cfreturn class.init(object=obj)/>
	</cffunction>

	<!---------------------------------------------------------------------------->
	
	<cffunction name="getMethods" returntype="array" access="public" output="false"
		hint="Returns an array containing Method objects reflecting all the public member methods 
				of the class or interface represented by this Class object, including those declared 
				by the class or interface and and those inherited from superclasses and superinterfaces. 
				The elements in the array returned are not sorted and are not in any particular order. 
				This method returns an array of length 0 if this Class object represents a class or 
				interface that has no public member methods, or if this Class object represents an array 
				class, primitive type, or void.">
				
		<cfset var metdata = variables.metadata>
		<cfset var i = 0>
		<cfset var methods = ArrayNew(1)>
		
		<cfloop condition="TRUE">
			<cfif StructKeyExists(metadata, "functions")>
				<cfloop index="i" from="1" to="#ArrayLen(metadata.functions)#">
					<cfif NOT StructKeyExists(metadata.functions[i], "access") OR metadata.functions[i].access IS "public">
						<cfset ArrayAppend(methods, metadata.functions[i])>
					</cfif>
				</cfloop>
			</cfif>
		
			<cfif StructKeyExists(metadata, "extends")>
				<cfset metadata = metadata.extends>
			<cfelse>
				<cfbreak/>
			</cfif>
		</cfloop>
		
		<cfreturn methods/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="getName" returntype="string" access="public" output="false" 
		hint="Returns the name of the entity (class, interface, array class, 
				primitive type, or void) represented by this Class object, as a String.">
				
		<cfreturn variables.metadata.name/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="getSuperClass" returntype="org.cfcunit.lang.Class" access="public" output="false" 
		hint="Returns the Class representing the superclass of the entity (class, interface, primitive 
				type or void) represented by this Class. If this Class represents either the Object class, 
				an interface, a primitive type, or void, then NULL is returned. If this object represents 
				an array class then the Class object representing the Object class is returned.">
		
		<cfif StructKeyExists(variables.metadata, "extends")>
			<cfreturn newObject("org.cfcunit.lang.Class").init(metadata=variables.metadata)/>
		<cfelse>
			<cfreturn newObject("org.cfcunit.lang.ClassNull").init()/>
		</cfif>
	</cffunction>	
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="isAssignableFrom" returntype="boolean" access="public" output="false">
		<cfargument name="class" type="org.cfcunit.lang.Class" required="true"/>
		
		<cfreturn TRUE/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="isInstance" returntype="boolean" access="public" output="false">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true"/>
		
		<cfreturn TRUE/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="newInstance" returntype="WEB-INF.cftags.component" access="public" output="false" 
		throws="Exception.Instantiation">
		
		<cftry>
			<cfreturn newObject(getName())/>
			
			<cfcatch type="any">
				<cfthrow type="Exception.Instantiation" message="Cannot instantiate oject for class '#getName()#'."/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

	<cffunction name="toStringValue" returntype="string" access="public" output="false" 
		hint="Converts the object to a string. The string representation is the string 'class' or 'interface', 
				followed by a space, and then by the fully qualified name of the class in the format returned 
				by getName. If this Class object represents a primitive type, this method returns the name of 
				the primitive type. If this Class object represents void this method returns 'void'.">
				
		<cfreturn "class #getName()#"/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="isComponent" returntype="boolean" access="private" output="false">
		<cfargument name="value" type="any" required="true"/>
		
		<cfif IsObject(arguments.value)>
			<cfif StructKeyExists(arguments.value, "type") AND arguments.value.type IS "component">
				<cfreturn TRUE/>
			</cfif>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

</cfcomponent>