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

<cfcomponent name="ErrorHelper" extends="org.cfcunit.Object" output="false" hint="">

	<!---------------------------------------------------------------------------------->

	<cfproperty name="databaseHelper" type="DatabaseErrorHelper" hint=""/>
	
	<cfset variables["databaseHelper"] = NULL>
	
	<!---------------------------------------------------------------------------------->

	<cffunction name="init" returntype="ErrorHelper" access="public" output="false" hint="">
		<cfset variables.databaseHelper = newObject("org.cfcunit.service.DatabaseErrorHelper")>
	
		<cfreturn this/>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->

	<cffunction name="getErrorInfo" returntype="struct" access="public" output="false" hint="">
		<cfargument name="exception" type="any" required="true" hint=""/>
		<!--- --->
		<cfset var data = StructNew()>
		<cfset var newStack = ArrayNew(1)>
		<cfset var stackTrace = arguments.exception.getStackTrace()>
		<cfset var i = 0>
		<cfset var curItem = "">
		<cfset var stackItem = "">
		
		<cfloop index="i" from="1" to="#ArrayLen(stackTrace)#">
			<cfset curItem = stackTrace[i]>
			<cfif ListFindNoCase("cfc,cfm,cfml", ListLast(curItem.getFileName(), "."), ",")>
				<cfset stackItem = StructNew()>
				<cfset stackItem["filename"] = curItem.getFilename()>
				<cfset stackItem["lineNumber"] = curItem.getLineNumber()>
				<cfset stackItem["className"] = curItem.getClassName()>
				<cfset stackItem["methodName"] = curItem.getMethodName()>
				
				<cfif stackItem.methodName IS "runFunction">
					<cfset stackItem["udfName"] = ListLast(stackItem.className, "$")>
					<cfset stackItem.udfName = Right(stackItem.udfName, Len(stackItem.udfName)-4)>
					<cfset stackItem.udfName = LCase(stackItem.udfName)>
				</cfif>
				
				<cfset ArrayAppend(newStack, stackItem)>
			</cfif>
		</cfloop>

		<cfset data["stackTrace"] = newStack>
		<cfset data["name"] = arguments.exception.class.name>
		<cfset data["message"] = arguments.exception.getMessage()>
		<cfset data["detail"] = arguments.exception.getDetail()>
		<cfset data["type"] = arguments.exception.getType()>
		
		<cfswitch expression="#arguments.exception.getType()#">
			<cfcase value="database">
				<cfset variables.databaseHelper.parseException(arguments.exception, data)>
			</cfcase>

			<cfcase value="template">
			</cfcase>
			
			<cfcase value="security">
			</cfcase>
			
			<cfcase value="object">
			</cfcase>
			
			<cfcase value="missingInclude">
			</cfcase>
			
			<cfcase value="expression">
			</cfcase>
			
			<cfcase value="lock">
			</cfcase>
			
			<cfcase value="searchengine">
			</cfcase>
						
			<cfcase value="application">
			</cfcase>
			
			<cfdefaultcase>
			</cfdefaultcase>
		</cfswitch>

		<cfreturn data/>
	</cffunction>
	
	<!---------------------------------------------------------------------------------->

</cfcomponent>