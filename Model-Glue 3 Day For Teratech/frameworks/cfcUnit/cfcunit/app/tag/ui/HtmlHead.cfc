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

<cfcomponent name="HtmlHead" output="false" hint="">

	<!--------------------------------------------------------------->

	<cfproperty name="fData" type="array" hint=""/>
	<cfproperty name="fKeys" type="struct" hint=""/>
	<cfproperty name="fCount" type="numeric" hint=""/>
	
	<cfset NULL = "">

	<cfset variables.fData = NULL>
	<cfset variables.fKeys = NULL>
	<cfset variables.fCount = NULL>
	
	<!--------------------------------------------------------------->

	<cffunction name="init" returntype="HtmlHead" access="public" output="false" hint="">
		<cfset variables.fData = ArrayNew(1)>
		<cfset variables.fKeys = StructNew()>
		<cfset variables.fCount = 0>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="addContent" returntype="void" access="public" output="false" hint="">
		<cfargument name="value" type="string" required="true"/>
		<cfargument name="id" type="string" required="false" default="#CreateUUID()#"/>
		<!--- --->
		<cfset var data = StructNew()>
		
		<cfif NOT StructKeyExists(variables.fKeys, newID)>
			<cfset data.id = arguments.id>
			<cfset data.content = arguments.value>
			<cfset variables.fCount = variables.fCount + 1>
			<cfset variables.fData[variables.fCount] = data>
			<cfset variables.fKeys[data.id] = variables.fCount>
		</cfif>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="size" returntype="numeric" access="public" output="false" hint="">
		<cfreturn variables.fCount/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="getContent" returntype="string" access="public" output="false" hint="">
		<cfargument name="index" type="numeric" required="true"/>
		<!--- --->
		<cfset var ret = NULL>
		
		<cfif arguments.index GT 0 AND arguments.index LTE variables.count>
			<cfset ret = variables.fData[arguments.index].content>
		</cfif>
		
		<cfreturn ret/>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>