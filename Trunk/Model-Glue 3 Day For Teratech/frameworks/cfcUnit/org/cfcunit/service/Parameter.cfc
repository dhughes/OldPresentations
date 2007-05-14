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

<cfcomponent name="Parameter" output="false">
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="init" returntype="Parameter" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="label" type="string" required="false"/>
		<cfargument name="type" type="string" required="false" default="any"/>
		<cfargument name="required" type="boolean" required="false" default="true"/>
		<cfargument name="default" type="any" required="false"/>
		
		<cfset setName(arguments.name)>
		
		<cfif structKeyExists(arguments, "label")>
			<cfset setLabel(arguments.label)>
		<cfelse>
			<cfset setLabel(arguments.name)>
		</cfif>
		
		<cfset setType(arguments.type)>
		<cfset setRequired(arguments.required)>
		
		<cfif structKeyExists(arguments, "default")>
			<cfset setDefault(arguments.default)>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getName" returntype="string" access="public" output="false">
		<cfreturn variables.name/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="setName" returntype="void" access="private" output="false">
		<cfargument name="name" type="string" required="true"/>
		
		<cfset variables.name = arguments.name>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getLabel" returntype="string" access="public" output="false">
		<cfreturn variables.label/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="setLabel" returntype="void" access="private" output="false">
		<cfargument name="label" type="string" required="true"/>
		
		<cfset variables.label = arguments.label>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getType" returntype="string" access="public" output="false">
		<cfreturn variables.type/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="setType" returntype="void" access="private" output="false">
		<cfargument name="type" type="string" required="true"/>
		
		<cfset variables.type = arguments.type>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="isRequired" returntype="boolean" access="public" output="false">
		<cfreturn variables.required/>
	</cffunction>

	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="setRequired" returntype="void" access="private" output="false">
		<cfargument name="required" type="boolean" required="true"/>
		
		<cfset variables.required = arguments.required>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getDefault" returntype="any" access="public" output="false">
		<cfreturn variables.default/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="setDefault" returntype="void" access="public" output="false">
		<cfargument name="default" type="any" required="true"/>
		
		<cfset variables.default = arguments.default>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>

</cfcomponent>