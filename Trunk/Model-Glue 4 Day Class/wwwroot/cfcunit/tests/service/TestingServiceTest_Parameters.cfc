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

<cfcomponent name="TestingServiceTest_Parameters" extends="org.cfcunit.service.TestParameters" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cfproperty name="parameters" type="any"/>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="init" returntype="TestingServiceTest_Parameters" access="public" output="false">
		<cfargument name="parameters" type="any" required="true"/>
		
		<cfset variables.parameters = arguments.parameters>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="getParameters" returntype="any" access="public" output="false">
		<cfreturn variables.parameters/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>