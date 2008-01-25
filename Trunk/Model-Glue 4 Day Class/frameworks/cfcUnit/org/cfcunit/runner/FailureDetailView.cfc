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

<cfcomponent extends="org.cfcunit.Object" displayname="Interface: FailureDetailView" output="false" hint="A view to show a details about a failure ">
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="clear" returntype="void" access="public" output="false" hint="Clears the view">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="getComponent" returntype="any" access="public" output="false" hint="Returns the component used to present the TraceView">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	
	<cffunction name="showFailure" returntype="void" access="public" output="false" hint="Shows details of a TestFailure">
		<cfargument name="failure" type="org.cfcunit.framework.TestFailure" required="true"/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------->

</cfcomponent>