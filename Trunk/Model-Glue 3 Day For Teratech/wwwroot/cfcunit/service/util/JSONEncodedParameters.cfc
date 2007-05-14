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

<cfcomponent name="JSONEncodedParameters" extends="org.cfcunit.service.TestParameters" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cfproperty name="parameters" type="string"/>

	
	<!------------------------------------------------------------------------------------>


	<cffunction name="init" returntype="JSONEncodedParameters" access="public" output="false">
		<cfargument name="parameters" type="string" required="false"/>
		
		<cfset var params = "">
		
		<cfif structKeyExists(arguments, "parameters")>
			<cfset params = parseParameterString(arguments.parameters)>
		</cfif>
		
		<cfset setParameters(params)>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="parseParameterString" returntype="any" access="public" output="false">
		<cfargument name="parameters" type="string" required="true"/>
		
		<cfset var json = createObject("component", "cfjson")>
		
		<cfreturn json.decode(arguments.parameters)/>
	</cffunction>
		
	<!------------------------------------------------------------------------------------>


	<cffunction name="getParameters" returntype="any" access="public" output="false">
		<cfreturn variables.parameters/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="setParameters" returntype="void" access="private" output="false">
		<cfargument name="parameters" type="any" required="true"/>
		
		<cfset variables.parameters = arguments.parameters>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="validate" returntype="void" access="public" output="false">
		<cfargument name="metadata" type="ParameterMetadata" required="true"/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>