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

<cfcomponent name="ResultHandler" output="false">

	<!--------------------------------------------------------------------->
	
	<cffunction name="getResults" returntype="any" access="public" output="false">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onStart" returntype="void" access="public" output="false">
		<cfargument name="testClassName" type="string" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onSuccess" returntype="void" access="public" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true" hint=""/>
		<cfargument name="runner" type="org.cfcunit.service.TestRunner" required="true" hint=""/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onError" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------------->

	<cffunction name="onFailure" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------------->		

	<cffunction name="onException" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------------->

</cfcomponent>