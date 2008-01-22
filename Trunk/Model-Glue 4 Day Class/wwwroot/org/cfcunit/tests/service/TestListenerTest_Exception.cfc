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

<cfcomponent name="TestListenerTest_Exception" output="false">

	<!------------------------------------------------------------------------------------>


	<cffunction name="init" returntype="TestListenerTest_Exception" access="public" output="false">
		<cfargument name="className" type="any" required="true"/>
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="detail" type="string" required="true"/>
		<cfargument name="type" type="string" required="true"/>
		
		<cfset this.class.name = arguments.className>
		<cfset variables.message = arguments.message>
		<cfset variables.detail = arguments.detail>
		<cfset variables.type = arguments.type>
		<cfset variables.stackTrace = arrayNew(1)>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="getMessage" returntype="string" access="public" output="false">
		<cfreturn variables.message/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getDetail" returntype="string" access="public" output="false">
		<cfreturn variables.detail/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="getType" returntype="string" access="public" output="false">
		<cfreturn variables.type/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="getStackTrace" returntype="array" access="public" output="false">
		<cfreturn variables.stackTrace/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="addTraceElement" returntype="void" access="public" output="false">
		<cfargument name="className" type="string" required="true"/>
		<cfargument name="filename" type="string" required="true"/>
		<cfargument name="lineNumber" type="numeric" required="true"/>
		<cfargument name="methodName" type="string" required="true"/>
		
		<cfset var element = createObject("component", "ErrorHelperTest_StackTraceElement").init(argumentCollection=arguments)>
		
		<cfset arrayAppend(variables.stackTrace, element)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>