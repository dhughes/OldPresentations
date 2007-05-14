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

<cfcomponent name="ParameterMetadataTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testCreation" returntype="void" access="public" output="false">
		<cfset var params = newObject("org.cfcunit.service.ParameterMetadata").init()>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testSingleNamedParameter" returntype="void" access="public" output="false">
		<cfset var params = newParameterMetadata()>
		<cfset var param = "">
		
		<cfset params.addParameter(name="one", type="string", required=false, default="")>
		
		<cfset param = params.getParameter("one")>
		
		<cfset assertEqualsString("one", param.getName(), "Name does not match.")>
		<cfset assertEqualsString("string", param.getType(), "Type does not match.")>
		<cfset assertFalse(param.isRequired(), "Parameter should not be required.")>
		<cfset assertEqualsString("", param.getDefault(), "Default does not match.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testSinglePositionedParameter" returntype="void" access="public" output="false">
		<cfset var params = newParameterMetadata()>
		<cfset var param = "">
		
		<cfset params.addParameter(name="one", type="string", required=false, default="")>
		
		<cfset param = params.getParameter(position=1)>
		
		<cfset assertEqualsString("one", param.getName(), "Name does not match.")>
		<cfset assertEqualsString("string", param.getType(), "Type does not match.")>
		<cfset assertFalse(param.isRequired(), "Parameter should not be required.")>
		<cfset assertEqualsString("", param.getDefault(), "Default does not match.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newParameterMetadata" returntype="org.cfcunit.service.ParameterMetadata" access="private" output="false">
		<cfreturn newObject("org.cfcunit.service.ParameterMetadata").init()/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>