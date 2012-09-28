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

<cfcomponent name="RuntimeService" extends="org.cfcunit.Object" output="false" hint="">

	<!------------------------------------------------------------------------------->

	<cfset variables.runtimeService = NULL>

	<!------------------------------------------------------------------------------->
		
	<cffunction name="init" returntype="RuntimeService" access="public" output="false" hint="">
		<cfset variables.runtimeService = CreateObject("java", "coldfusion.server.ServiceFactory").RuntimeService>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="getMappings" returntype="struct" access="public" output="false" hint="">
		<cflock name="cfadmin_runtime" type="readonly" timeout="5">
			<cfreturn variables.runtimeService.getMappings()/>
		</cflock>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="getCustomtags" returntype="struct" access="public" output="false" hint="">
		<cflock name="cfadmin_runtime" type="readonly" timeout="5">
			<cfreturn variables.runtimeService.getCustomtags()/>
		</cflock>
	</cffunction>
	
	<!------------------------------------------------------------------------------->

</cfcomponent>