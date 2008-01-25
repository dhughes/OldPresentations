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

<cfcomponent name="DatabaseErrorHelper" output="false" hint="">

	<!---------------------------------------------------------------------------------->
	
	<cffunction name="parseException" returntype="void" access="public" output="false" hint="">
		<cfargument name="exception" type="any" required="true" hint=""/>
		<cfargument name="data" type="struct" required="true" hint=""/>
		
		<cfif StructKeyExists(arguments.exception, "DataSource")>
			<cfset arguments.data["datasource"] = arguments.exception.DataSource>
		<cfelse>
			<cfset arguments.data["datasource"] = "N/A">
		</cfif>
		<cfset arguments.data["nativeErrorCode"] = arguments.exception.nativeErrorCode>
		<cfset arguments.data["sqlState"] = arguments.exception.sqlState>
		<cfif StructKeyExists(arguments.exception, "sql")>
			<cfset arguments.data["sql"] = arguments.exception.sql>
			<cfset arguments.data["where"] = parseWhere(arguments.exception)>
		<cfelse>
			<cfset arguments.data["sql"] = "N/A">
			<cfset arguments.data["where"] = ArrayNew(1)>
		</cfif>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->

	<cffunction name="parseWhere" returntype="array" access="private" output="false" hint="">
		<cfargument name="exception" type="any" required="true" hint=""/>
		<!--- --->
		<cfset var where = arguments.exception.where>
		<cfset var ret = ArrayNew(1)>
		<cfset var i = 0>
		<cfset var aWhere = ListToArray(where, "[]")>
		<cfset var param = "">
		<cfset var pairs = "">
		<cfset var pair = "">

		<cfloop index="i" from="1" to="#ArrayLen(aWhere)-2#" step="2">
			<cfset param = StructNew()>
			<cfset param["param"] = Trim(ListLast(ReplaceList(aWhere[i], "(,),=", ",,"), ","))>
			<cfset pairs = aWhere[i+1]>
			<cfset param["properties"] = StructNew()>
			
			<cfloop list="#pairs#" index="pair" delimiters=",">
				<cfset param.properties[Trim(ListFirst(pair, "="))] = Trim(ListLast(pair, "="))>
			</cfloop>
			<cfset ArrayAppend(ret, param)>
		</cfloop>
		
		<cfreturn ret/>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->

</cfcomponent>