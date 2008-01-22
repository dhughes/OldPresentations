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

<cfcomponent displayname="Interface: iTestCollector" extends="org.cfcunit.Object" output="false" 
	hint="Collects Test class names to be presented by the TestSelector.">

	<!------------------------------------------------------------------------>
	
	<cfproperty name="dirDelim" displayname="protected" type="string" default="\"/>
	<cfproperty name="pathSeparator" displayname="protected" type="string" default=";"/>
	
	<!------------------------------------------------------------------------------->
	
	<cfset dirDelim = Right(ExpandPath("./"), 1)>
	<cfset pathSeparator = ";">
	
	<!------------------------------------------------------------------------>
	
	<cffunction name="collectTests" returntype="array" access="public" output="false" hint="Returns an array of strings with qualified class names.">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------>

</cfcomponent>