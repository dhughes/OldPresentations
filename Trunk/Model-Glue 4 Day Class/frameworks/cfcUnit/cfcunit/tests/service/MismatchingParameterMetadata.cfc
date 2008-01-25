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

<cfcomponent name="MismatchingParameterMetadata" extends="org.cfcunit.service.ParameterMetadata" output="false">

	<cffunction name="init" returntype="MismatchingParameterMetadata" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="validateParameters" returntype="void" access="public" output="false">
		<cfargument name="parameters" type="org.cfcunit.service.TestParameters" required="true"/>
		
		<cfthrow type="Exception.ParameterMismatch"/>
	</cffunction>

</cfcomponent>