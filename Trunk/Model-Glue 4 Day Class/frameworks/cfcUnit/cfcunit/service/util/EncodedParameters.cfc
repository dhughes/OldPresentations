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

<!---
$Id: EncodedParameters.cfc,v 1.3 2006/12/16 09:54:59 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/util/EncodedParameters.cfc,v $
--->

<cfcomponent name="EncodedParameters" extends="org.cfcunit.service.TestParameters" output="false">

	<!------------------------------------------------------------------------------------>


	<cfproperty name="parameters" type="any"/>
	<cfproperty name="parameterMetadata" type="org.cfcunit.service.ParameterMetadata"/>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="init" returntype="EncodedParameters" access="public" output="false">
		<cfargument name="parameters" type="string" required="false" default=""/>
		
		<cfset var params = parseParameterString(arguments.parameters)>
		<cfset var metadata = createObject("component", "org.cfcunit.service.ParameterMetadata").init()>
		
		<cfset setParameters(params)>
		
		<cfset metadata.addParameter(name="args", label="Test Args", type="string", required=false, default="")>
		
		<cfset variables.parameterMetadata = metadata>
		
		<cfreturn this/>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="parseParameterString" returntype="any" access="public" output="false">
		<cfargument name="parameters" type="string" required="true"/>
		
		<cfset var namedDelimPos = find(namedParameterDelimiter(), arguments.parameters, 1)>
		<cfset var unnamedDelimPos = find(unnamedParameterDelimiter(), arguments.parameters, 1)>
		<cfset var nameValueDelimPos = find(nameValueDelimiter(), arguments.parameters, 1)>
		
		<cfif len(arguments.parameters)>
			<cfif nameValueDelimPos gt 0 or namedDelimPos gt 0>
				<cfif unnamedDelimPos gt 0>
					<cfif unnamedDelimPos lt nameValueDelimPos or unnamedDelimPos lt namedDelimPos>
						<cfreturn parseUnnamedParameters(arguments.parameters)/>
					</cfif>
					
					<cfreturn parseNamedParameters(arguments.parameters)/>
				</cfif>
			<cfelse>
				<cfreturn parseUnnamedParameters(arguments.parameters)/>
			</cfif>
			
			
			<cfreturn parseNamedParameters(arguments.parameters)/>
		<cfelse>
			<cfreturn parseNamedParameters(arguments.parameters)/>
		</cfif>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="parseNamedParameters" returntype="struct" access="private" output="false">
		<cfargument name="parameters" type="string" required="true"/>
		
		<cfset var paramArray = listToArray(arguments.parameters, namedParameterDelimiter())>
		<cfset var i = 0>
		<cfset var params = structNew()>
		
		<cfloop index="i" from="1" to="#ArrayLen(paramArray)#">
			<cfset params[listFirst(paramArray[i], nameValueDelimiter())] = listRest(paramArray[i], nameValueDelimiter())>
		</cfloop>
		
		<cfreturn params/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="parseUnnamedParameters" returntype="array" access="private" output="false">
		<cfargument name="parameters" type="string" required="true"/>
		
		<cfreturn listToArray(arguments.parameters, unnamedParameterDelimiter())/>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="setParameters" returntype="void" access="private" output="false">
		<cfargument name="parameters" type="any" required="true"/>
		
		<cfif isStruct(arguments.parameters)>
			<cfset variables.parameters = StructCopy(arguments.parameters)>
		<cfelseif isArray(arguments.parameters)>
			<cfset variables.parameters = arguments.parameters>
		<cfelse>
			<cfthrow message="Parameters collection can only be a struct or array."
					 detail="#arguments.parameters.toString()#">
		</cfif>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getParameters" returntype="any" access="public" output="false">
		<cfreturn variables.parameters/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="getParameterMetadata" returntype="org.cfcunit.service.ParameterMetadata" access="public" output="false">
		<cfreturn variables.parameterMetadata/>
	</cffunction>
	
	
	
	<!------------------------------------------------------------------------------------>
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="namedParameterDelimiter" returntype="string" access="private" output="false">
		<cfreturn ";"/>
	</cffunction>
	
	<cffunction name="nameValueDelimiter" returntype="string" access="private" output="false">
		<cfreturn ":"/>
	</cffunction>

	<cffunction name="unnamedParameterDelimiter" returntype="string" access="private" output="false">
		<cfreturn ","/>
	</cffunction>

	
	<!------------------------------------------------------------------------------------>

</cfcomponent>