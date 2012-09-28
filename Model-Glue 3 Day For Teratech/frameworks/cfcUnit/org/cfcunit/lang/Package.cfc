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

<cfcomponent name="Package" extends="org.cfcunit.Object">
	
	<!------------------------------------------------------------------------------------>
	
	<cfproperty name="name" type="string" hint=""/>
	
	<cfset variables["name"] = NULL>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="init" returntype="Package" access="package" output="false">
		<cfargument name="metadata" type="any" required="true"/>
		
		<cfset variables.name = arguments.metadata.name>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="getName" returntype="string" access="public" output="false" 
		hint="The name of this package using the Java language dot notation for the package. i.e java.lang">
		
		<cfreturn variables.name/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="getHashCode" returntype="string" access="public" output="false" hint="Return the hash code computed from the package name.">
		<cfreturn Hash(variables.name)/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false" 
		hint="Returns the string representation of this Package. Its value is the string 
				'package', a space and the package name. If the package title is defined 
				it is appended. If the package version is defined it is appended.">
	
		<cfreturn "package #getName()#"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
</cfcomponent>