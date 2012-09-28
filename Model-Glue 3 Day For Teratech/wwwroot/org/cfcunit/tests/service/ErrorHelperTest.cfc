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

<cfcomponent name="ErrorHelperTest" extends="org.cfcunit.framework.TestCase" output="false">
	
	<!-------------------------------------------------------------------->
	
	
	<cfproperty name="helper" type="org.cfcunit.service.ErrorHelper"/>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="setUp" returntype="void" access="public" output="false">
		<cfset variables.helper = newObject("org.cfcunit.service.ErrorHelper").init()>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testGetErrorInfo" returntype="void" access="public" output="false">
		<cfset var helper = variables.helper>
		<cfset var args = structNew()>
		<cfset var exception = "">
		<cfset var expected = structNew()>
		<cfset var actual = "">

		<cfset args.className = "coldfusion.runtime.CustomException">
		<cfset args.message = "This is a test.">
		<cfset args.detail = "Yes, I mean it.">
		<cfset args.type = "Application">

		<cfset exception = createObject("component", "ExceptionStub").init(argumentCollection=args)>

		<cfset exception.addTraceElement("coldfusion.tagext.lang.ThrowTag", "ThrowTag.java", 124, "doStartTag")>
		<cfset exception.addTraceElement("coldfusion.runtime.CfJspPage", "CfJspPage.java", 2469, "_emptyTag")>
		<cfset exception.addTraceElement("cfErrorHelperTest2ecfc98211095$funcTESTGETERRORINFO", "/cfcunit/org/cfcunit/tests/service/ErrorHelperTest.cfc", 58, "runFunction")>
		
		<cfset actual = helper.getErrorInfo(exception)>
		
		<cfset expected = structNew()>
		<cfset expected["detail"] = "Yes, I mean it.">
		<cfset expected["message"] = "This is a test.">
		<cfset expected["name"] = "coldfusion.runtime.CustomException">
		<cfset expected["type"] = "Application">
		<cfset expected["stackTrace"] = arrayNew(1)>
		<cfset expected.stacktrace[1] = structNew()>
		<cfset expected.stacktrace[1]["className"] = "cfErrorHelperTest2ecfc98211095$funcTESTGETERRORINFO">
		<cfset expected.stacktrace[1]["filename"] = "/cfcunit/org/cfcunit/tests/service/ErrorHelperTest.cfc">
		<cfset expected.stacktrace[1]["lineNumber"] = 58>
		<cfset expected.stacktrace[1]["methodName"] = "runFunction">
		<cfset expected.stacktrace[1]["udfName"] = "testgeterrorinfo">
				
		<cfset assertEqualsStruct(expected, actual, "Exception info structs are not the same.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
	
	<cffunction name="testGetDatabaseErrorInfo" returntype="void" access="public" output="false">
		<cfset var helper = variables.helper>
		<cfset var args = structNew()>
		<cfset var exception = "">
		<cfset var expected = structNew()>
		<cfset var actual = "">
		
		<cfset args.className = "coldfusion.runtime.CustomException">
		<cfset args.message = "This is a test.">
		<cfset args.detail = "Yes, I mean it.">
		<cfset args.datasource = "testDSN">
		<cfset args.nativeErrorCode = "123">
		<cfset args.sqlState = "No clue">
		<cfset args.sql = "SELECT * FROM TABLE WHERE 1 = 0">
		<cfset args.where = "">

		<cfset exception = createObject("component", "DatabaseExceptionStub").init(argumentCollection=args)>
		
		<cfset exception.addTraceElement("coldfusion.tagext.lang.ThrowTag", "ThrowTag.java", 124, "doStartTag")>
		<cfset exception.addTraceElement("coldfusion.runtime.CfJspPage", "CfJspPage.java", 2469, "_emptyTag")>
		<cfset exception.addTraceElement("cfErrorHelperTest2ecfc98211095$funcTESTGETERRORINFO", "/cfcunit/org/cfcunit/tests/service/ErrorHelperTest.cfc", 58, "runFunction")>
	
		<cfset expected["detail"] = "Yes, I mean it.">
		<cfset expected["message"] = "This is a test.">
		<cfset expected["name"] = "coldfusion.runtime.CustomException">
		<cfset expected["type"] = "Database">
		<cfset expected["datasource"] = "testDSN">
		<cfset expected["nativeErrorCode"] = "123">
		<cfset expected["sqlState"] = "No clue">
		<cfset expected["sql"] = "SELECT * FROM TABLE WHERE 1 = 0">
		<cfset expected["where"] = arrayNew(1)>
		<cfset expected["stackTrace"] = arrayNew(1)>
		<cfset expected.stacktrace[1] = structNew()>
		<cfset expected.stacktrace[1]["className"] = "cfErrorHelperTest2ecfc98211095$funcTESTGETERRORINFO">
		<cfset expected.stacktrace[1]["filename"] = "/cfcunit/org/cfcunit/tests/service/ErrorHelperTest.cfc">
		<cfset expected.stacktrace[1]["lineNumber"] = 58>
		<cfset expected.stacktrace[1]["methodName"] = "runFunction">
		<cfset expected.stacktrace[1]["udfName"] = "testgeterrorinfo">

		<cfset actual = helper.getErrorInfo(exception)>
		
		<cfset assertEqualsStruct(expected, actual, "Exception info structs are not the same.")>
	</cffunction>
	
	
	<!-------------------------------------------------------------------->
	
</cfcomponent>