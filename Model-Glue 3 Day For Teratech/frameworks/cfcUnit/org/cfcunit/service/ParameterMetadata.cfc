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

<cfcomponent name="ParameterMetadata" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cfproperty name="namedParameters" type="struct"/>
	<cfproperty name="indexedParameters" type="array"/>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="init" returntype="ParameterMetadata" access="public" output="false">
		<cfset variables.namedParameters = structNew()>
		<cfset variables.indexedParameters = arrayNew(1)>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="addParameter" returntype="void" access="public" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="label" type="string" required="false"/>
		<cfargument name="type" type="string" required="false" default="any"/>
		<cfargument name="required" type="boolean" required="false" default="true"/>
		<cfargument name="default" type="any" required="false"/>

		<cfset var parameter = createObject("component", "Parameter").init(argumentCollection=arguments)>
		
		<cfset variables.namedParameters[parameter.getName()] = parameter>
		<cfset arrayAppend(variables.indexedParameters, parameter)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getParameter" returntype="Parameter" access="public" output="false">
		<cfargument name="name" type="string" required="false"/>
		<cfargument name="position" type="numeric" required="false"/>
		
		<cfif structKeyExists(arguments, "name")>
			<cfreturn variables.namedParameters[arguments.name]/>
		</cfif>
		
		<cfif structKeyExists(arguments, "position")>
			<cfreturn variables.indexedParameters[arguments.position]/>
		</cfif>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getParameterNames" returntype="array" access="public" output="false">
		<cfset var names = arrayNew(1)>
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="#arrayLen(variables.indexedParameters)#">
			<cfset arrayAppend(names, variables.indexedParameters[i].getName())>
		</cfloop>
		
		<cfreturn names/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getParameterList" returntype="any" access="public" output="false">
		<cfreturn variables.indexedParameters/>
	</cffunction>


	<!------------------------------------------------------------------------------------>


	<cffunction name="getParameterStruct" returntype="any" access="public" output="false">
		<cfreturn structCopy(variables.namedParameters)/>
	</cffunction>


	<!------------------------------------------------------------------------------------>
	

	<cffunction name="validateParameters" returntype="void" access="public" output="false">
		<cfargument name="parameters" type="TestParameters" required="true"/>

		<!--- Do nothing right now. --->
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>