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

<cfcomponent name="Object" output="false" hint="This is the base object for the CFCUnit framework.">
	
	<!--------------------------------------------------------------->
	
	<cfproperty name="_objectID" displayname="private" type="numeric" default=""/>
	
	<cfset NULL = "">

	<cfset variables["_objectID"] = CreateObject("java", "java.lang.System").identityHashCode(this)>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="init" returntype="Object" access="public" output="false" hint="">
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="objectID" returntype="numeric" access="public" output="false">
		<cfreturn variables._objectID/>
	</cffunction>
	
	<!--------------------------------------------------------------->
		
	<cffunction name="newObject" returntype="WEB-INF.cftags.component" access="private" output="false" hint="">
		<cfargument name="type" type="string" required="true"/>

		<cfreturn CreateObject("component", arguments.type)/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="newJavaObject" returntype="any" access="private" output="false" hint="Creates an uninitialized java object.">
		<cfargument name="class" type="string" required="true"/>
		
		<cfreturn CreateObject("java", arguments.class)/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getCFCMetadata" returntype="struct" access="public" output="false">
		<cfreturn getMetadata(this)/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn getCFCMetadata().name & "(" & objectID() & ")"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="isCFCType" returntype="boolean" access="private" output="false">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true"/>
		<cfargument name="type" type="string" required="true"/>
		<!--- --->
		<cfset var typeNameLen = Len(arguments.type)>
		<cfset var metadata = getMetadata(arguments.object)>
		
		<cfif typeNameLen IS 0>
			<cfthrow type="Exception.InvalidArgument" message="Parameter 'type' is zero length."/>
		</cfif>
		
		<cfloop condition="TRUE">
			<cfif Right(metadata.name, typeNameLen) IS arguments.type>
				<cfreturn TRUE/>
			<cfelseif StructKeyExists(metadata, "extends")>
				<cfset metadata = metadata.extends>
			<cfelse>
				<cfbreak/>
			</cfif>
		</cfloop>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="isNull" returntype="boolean" access="public" output="false">
		<cfreturn FALSE/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="equalsObject" returntype="boolean" access="public" output="false">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true"/>

		<cftry>
			<cfif getHashCode() NEQ arguments.object.getHashCode()>
				<cfreturn FALSE/>
			</cfif>
			
			<cfcatch type="any">
				<cfreturn FALSE/>
			</cfcatch>
		</cftry>
		
		<cfreturn TRUE/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getHashCode" returntype="string" access="public" output="false">
		<cfreturn Hash(variables.objectID)/>
	</cffunction>
	
	
	<!--------------------------------------------------------------->
	
	
	<cffunction name="getStackTrace" returntype="array" access="private" output="false">
		<cfset var throwable = createObject("java", "java.lang.Throwable").init()>
		<cfset var stackTrace = throwable.getStackTrace()>
		<cfset var trace = arrayNew(1)>
		<cfset var element = "">
		
		<cfloop index="i" from="1" to="#arrayLen(stackTrace)#">
			<cfset element = structNew()>
			<cfset element["className"] = stackTrace[i].getClassName()>
			<cfset element["fileName"] = stackTrace[i].getFileName()>
			<cfset element["lineNumber"] = stackTrace[i].getLineNumber()>
			<cfset element["methodName"] = stackTrace[i].getMethodName()>
			<cfset element["isNativeMethod"] = stackTrace[i].isNativeMethod()>
			<cfset element["string"] = stackTrace[i].toString()>
			
			<cfset arrayAppend(trace, element.string)>
		</cfloop>
		
		<cfreturn trace/>
	</cffunction>
	
	
	<!--------------------------------------------------------------->

</cfcomponent>