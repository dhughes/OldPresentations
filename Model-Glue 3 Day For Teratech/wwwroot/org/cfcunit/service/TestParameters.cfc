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
$Id: TestParameters.cfc,v 1.2 2006/12/09 09:12:19 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/org/cfcunit/service/TestParameters.cfc,v $
--->

<cfcomponent name="TestParameters" output="false">

	<!------------------------------------------------------------------------------------>
	
	<cffunction name="getParameters" returntype="any" access="public" output="false">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="validate" returntype="void" access="public" output="false">
		<cfargument name="metadata" type="ParameterMetadata" required="true"/>
		
		<cfset arguments.metadata.validateParameters(this)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
</cfcomponent>