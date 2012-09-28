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

<cfcomponent name="DatabaseErrorHelperTest" extends="org.cfcunit.framework.TestCase" output="false">
	
	<!-------------------------------------------------------------------->
	
	
	<cfproperty name="errorHelper" type="org.cfcunit.service.DatabaseErrorHelper"/>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
		<cfset variables.errorHelper = newObject("org.cfcunit.service.DatabaseErrorHelper")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testParseExceptionWithEmptyWhere" returntype="void" access="public" output="false">
		<cfset var dbHelper = variables.errorHelper>
		<cfset var exception = structNew()>
		<cfset var expectedData = structNew()>
		<cfset var actualData = structNew()>
		
		<cfset exception["Datasource"] = "testDSN">
		<cfset exception["nativeErrorCode"] = "123">
		<cfset exception["sqlState"] = "No clue">
		<cfset exception["sql"] = "SELECT * FROM TABLE WHERE 1 = 0">
		<cfset exception["where"] = "">
		
		<cfset expectedData["datasource"] = "testDSN">
		<cfset expectedData["nativeErrorCode"] = "123">
		<cfset expectedData["sqlState"] = "No clue">
		<cfset expectedData["sql"] = "SELECT * FROM TABLE WHERE 1 = 0">
		<cfset expectedData["where"] = arrayNew(1)>
		
		<cfset dbHelper.parseException(exception, actualData)>
		
		<cfset assertEqualsStruct(expectedData, actualData, "Structs should be the same.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->


	<cffunction name="testParseExceptionWithoutDatasource" returntype="void" access="public" output="false">
		<cfset var dbHelper = variables.errorHelper>
		<cfset var exception = structNew()>
		<cfset var expectedData = structNew()>
		<cfset var actualData = structNew()>
		
		<cfset exception["nativeErrorCode"] = "123">
		<cfset exception["sqlState"] = "No clue">
		<cfset exception["sql"] = "SELECT * FROM TABLE WHERE 1 = 0">
		<cfset exception["where"] = "">
		
		<cfset expectedData["datasource"] = "N/A">
		<cfset expectedData["nativeErrorCode"] = "123">
		<cfset expectedData["sqlState"] = "No clue">
		<cfset expectedData["sql"] = "SELECT * FROM TABLE WHERE 1 = 0">
		<cfset expectedData["where"] = arrayNew(1)>
		
		<cfset dbHelper.parseException(exception, actualData)>
		
		<cfset assertEqualsStruct(expectedData, actualData, "Structs should be the same.")>
	</cffunction>
	

	<!-------------------------------------------------------------------->


	<cffunction name="testParseExceptionWithoutSQL" returntype="void" access="public" output="false">
		<cfset var dbHelper = variables.errorHelper>
		<cfset var exception = structNew()>
		<cfset var expectedData = structNew()>
		<cfset var actualData = structNew()>
		
		<cfset exception["Datasource"] = "testDSN">
		<cfset exception["nativeErrorCode"] = "123">
		<cfset exception["sqlState"] = "No clue">
		
		<cfset expectedData["datasource"] = "testDSN">
		<cfset expectedData["nativeErrorCode"] = "123">
		<cfset expectedData["sqlState"] = "No clue">
		<cfset expectedData["sql"] = "N/A">
		<cfset expectedData["where"] = arrayNew(1)>
		
		<cfset dbHelper.parseException(exception, actualData)>
		
		<cfset assertEqualsStruct(expectedData, actualData, "Structs should be the same.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testParseExceptionWithSingleWhereParameter" returntype="void" access="public" output="false">
		<cfset var dbHelper = variables.errorHelper>
		<cfset var exception = structNew()>
		<cfset var expectedWhere = arrayNew(1)>
		<cfset var actualData = structNew()>
		
		<cfset exception["Datasource"] = "testDSN">
		<cfset exception["nativeErrorCode"] = "1146">
		<cfset exception["sqlState"] = "42S02">
		<cfset exception["sql"] = "SELECT * FROM people WHERE name = (param 1)">
		<cfset exception["where"] = " (param 1) = [type='IN', class='java.lang.String', value='dude', sqltype='cf_sql_varchar'] ">
		
		<cfset expectedWhere[1] = createWhereParam("param 1", "IN", "java.lang.String", "dude", "cf_sql_varchar")>
		
		<cfset dbHelper.parseException(exception, actualData)>
		
		<cfif false>
			<cfdump var="#expectedWhere#"/>
			<cfdump var="#actualData.where#"/>
			<cfabort/>
		</cfif>

		<cfset assertEqualsArray(expectedWhere, actualData.where)>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->


	<cffunction name="testParseExceptionWithTwoWhereParameters" returntype="void" access="public" output="false">
		<cfset var dbHelper = variables.errorHelper>
		<cfset var exception = structNew()>
		<cfset var expectedWhere = arrayNew(1)>
		<cfset var actualData = structNew()>
		
		<cfset exception["Datasource"] = "testDSN">
		<cfset exception["nativeErrorCode"] = "1146">
		<cfset exception["sqlState"] = "42S02">
		<cfset exception["sql"] = "SELECT * FROM people WHERE firstname = (param 1) AND lastname = (param 2)">
		<cfset exception["where"] = " (param 1) = [type='IN', class='java.lang.String', value='the', sqltype='cf_sql_varchar'] "
									& ", (param 2) = [type='IN', class='java.lang.String', value='dude', sqltype='cf_sql_varchar'] ">
		
		
		<cfset expectedWhere[1] = createWhereParam("param 1", "IN", "java.lang.String", "the", "cf_sql_varchar")>
		<cfset expectedWhere[2] = createWhereParam("param 2", "IN", "java.lang.String", "dude", "cf_sql_varchar")>
		
		<cfset dbHelper.parseException(exception, actualData)>

		<cfset assertEqualsArray(expectedWhere, actualData.where)>
	</cffunction>

	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testParseExceptionWithMultipleWhereParameters" returntype="void" access="public" output="false">
		<cfset var dbHelper = variables.errorHelper>
		<cfset var exception = structNew()>
		<cfset var expectedWhere = arrayNew(1)>
		<cfset var actualData = structNew()>
		
		<cfset exception["Datasource"] = "testDSN">
		<cfset exception["nativeErrorCode"] = "1146">
		<cfset exception["sqlState"] = "42S02">
		<cfset exception["sql"] = "SELECT * FROM people WHERE firstname = (param 1) AND lastname = (param 2) AND title = (param 3)">
		<cfset exception["where"] = " (param 1) = [type='IN', class='java.lang.String', value='the', sqltype='cf_sql_varchar'] "
									& ", (param 2) = [type='IN', class='java.lang.String', value='dude', sqltype='cf_sql_varchar'] "
									& ", (param 3) = [type='IN', class='java.lang.String', value='jr.', sqltype='cf_sql_varchar'] ">
		
		
		<cfset expectedWhere[1] = createWhereParam("param 1", "IN", "java.lang.String", "the", "cf_sql_varchar")>
		<cfset expectedWhere[2] = createWhereParam("param 2", "IN", "java.lang.String", "dude", "cf_sql_varchar")>
		<cfset expectedWhere[3] = createWhereParam("param 3", "IN", "java.lang.String", "jr.", "cf_sql_varchar")>
		
		<cfset dbHelper.parseException(exception, actualData)>

		<cfset assertEqualsArray(expectedWhere, actualData.where)>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="createWhereParam" returntype="struct" access="private" output="false">
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="type" type="string" required="true"/>
		<cfargument name="class" type="string" required="true"/>
		<cfargument name="value" type="string" required="true"/>
		<cfargument name="sqltype" type="string" required="true"/>
		
		<cfset var where = structNew()>
		
		<cfset where["param"] = arguments.name>
		<cfset where["properties"] = structNew()>
		<cfset where.properties["type"] = "'#arguments.type#'">
		<cfset where.properties["class"] = "'#arguments.class#'">
		<cfset where.properties["value"] = "'#arguments.value#'">
		<cfset where.properties["sqltype"] = "'#arguments.sqltype#'">
		
		<cfreturn where/>
	</cffunction>
	
	
	
	<!-------------------------------------------------------------------->
	
</cfcomponent>