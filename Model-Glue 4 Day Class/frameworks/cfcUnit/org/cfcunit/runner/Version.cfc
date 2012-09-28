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

<cfcomponent displayname="Version" extends="org.cfcunit.Object" output="false" 
	hint="This class defines the current version of cfcUnit">
	
	<!------------------------------------------------------------------------------>
	
	<cfproperty name="productName" displayname="private" type="string" default="cfcUnit"/>
	<cfproperty name="versionMajor" displayname="private" type="string" default="1"/>
	<cfproperty name="versionMinor" displayname="private" type="string" default="0"/>
	
	<!------------------------------------------------------------------------------>
	
	<cfset variables.productName = "cfcUnit">
	<cfset variables.versionMajor = "1">
	<cfset variables.versionMinor = "1">
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="id" returntype="string" access="public" output="false">
		<cfset var versionNumber = " v" & variables.versionMajor & "." & variables.versionMinor>
		<cfreturn variables.productName & versionNumber/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>

</cfcomponent>