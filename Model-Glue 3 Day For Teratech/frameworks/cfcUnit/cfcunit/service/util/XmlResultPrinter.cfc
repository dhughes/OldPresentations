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

<cfcomponent name="XmlResultPrinter" extends="org.cfcunit.framework.TestListener" output="false" hint="">

	<!----------------------------------------------------------------------->
	
	<cfproperty name="xml" type="any" hint="XML document for test suite results."/>
	<cfproperty name="currentTestData" type="struct"/>
	<cfproperty name="currentTestNode" type="any" hint="XML node of current test"/>
	<cfproperty name="testCount" type="numeric"/>
	<cfproperty name="failureCount" type="numeric"/>
	<cfproperty name="errorCount" type="numeric"/>
	<cfproperty name="helper" type="org.cfcunit.service.ErrorHelper" hint=""/>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="init" returntype="XmlResultPrinter" access="public" output="false">
		<cfset variables.helper = newObject("org.cfcunit.service.ErrorHelper").init()>

		<cfset reset()>
				
		<cfreturn this/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="reset" returntype="void" access="public" output="false">
		<cfset variables.xml = "">
		<cfset variables.currentTestData = "">
		<cfset variables.currentTestNode = "">
		<cfset variables.testCount = 0>
		<cfset variables.failureCount = 0>
		<cfset variables.errorCount = 0>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="setXml" returntype="void" access="public" output="false">
		<cfargument name="xml" type="any" required="true"/>
		
		<cfset variables.xml = arguments.xml>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getXml" returntype="any" access="public" output="false">
		<cfreturn variables.xml/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="addError" returntype="void" access="public" output="false" hint="An error occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="error" type="any" required="true"/>

		<cfset var currentTest = variables.currentTestData>
		<cfset var testNode = variables.currentTestNode>
		<cfset var exceptionInfo = "">
		<cfset var i = 0>
		<cfset var curItem = "">
		<cfset var traceNode = "">
		<cfset var dbNode = "">
		<cfset var param = "">
		<cfset var paramNode = "">
		
		<cfset currentTest["hasFailure"] = TRUE>
		<cfset currentTest["failure"] = StructNew()>
		<cfset currentTest["failure"]["failureType"] = "Error">
		<cfset currentTest["failure"]["exception"] = arguments.error>

		<cfset exceptionInfo = variables.helper.getErrorInfo(arguments.error)>
		
		<cfset testNode["error"] = XmlElemNew(variables.xml, "error")>
		<cfset testNode["error"].XmlAttributes["cfml-exception"] = arguments.error.type>
		<cfset testNode["error"].XmlAttributes["java-exception"] = exceptionInfo.name>
		<cfset testNode["error"].XmlAttributes["detail"] = exceptionInfo.detail>
		<cftry>
			<cfset testNode["error"].XmlAttributes["message"] = exceptionInfo.message>
			<cfcatch type="any">
				<cfset testNode["error"].XmlAttributes["message"] = "">
			</cfcatch>
		</cftry>
		<cfset testNode["error"]["stack-trace"] = XmlElemNew(variables.xml, "stack-trace")>

		<cfloop index="i" from="1" to="#ArrayLen(exceptionInfo.stackTrace)#">
			<cfset curItem = exceptionInfo.stackTrace[i]>
			
			<cfset traceNode = XmlElemNew(variables.xml, "line")>
			<cfset traceNode.XmlAttributes["filename"] = curItem.filename>
			<cfset traceNode.XmlAttributes["line"] = curItem.lineNumber>
			<cfif StructKeyExists(curItem, "udfName")>
				<cfset traceNode.XmlAttributes["method"] = curItem.udfName>
			</cfif>
			
			<cfset ArrayAppend(testNode["error"]["stack-trace"].XmlChildren, traceNode)>
		</cfloop>

		<cfif arguments.error.type IS "database">
			<cfset dbNode = XmlElemNew(variables.xml, "database-error")>
			<cfset dbNode.XmlAttributes["datasource"] = exceptionInfo.dataSource>
			<cfset dbNode.XmlAttributes["native-error-code"] = exceptionInfo.nativeErrorCode>
			<cfset dbNode.XmlAttributes["sql-state"] = exceptionInfo.sqlState>
			<cfset dbNode.XmlAttributes["sql-statement"] = exceptionInfo.sql>
			<cfset dbNode["bind-parameters"] = XmlElemNew(variables.xml, "bind-parameters")>
			
			<cfloop index="i" from="1" to="#ArrayLen(exceptionInfo.where)#">
				<cfset param = exceptionInfo.where[i]>
				
				<cfset paramNode = XmlElemNew(variables.xml, "bind-parameter")>
				<cfset paramNode.XmlAttributes["param"] = param.param>
				<cfset paramNode.XmlAttribites["type"] = param.properties.type>
				<cfset paramNode.XmlAttributes["sqltype"] = param.properties.sqltype>
				<cfif StructKeyExists(param.properties, "class")>
					<cfset paramNode.XmlAttributes["class"] = param.properties.class>
				</cfif>
				<cfset paramNode.XmlAttributes["value"] = param.properties.value>
				
				<cfset ArrayAppend(dbNode["bind-parameters"].XmlChildren, paramNode)>
			</cfloop>
			
			<cfset testNode["error"]["database-error"] = dbNode>
		</cfif>
		
		<cfset variables.errorCount = variables.errorCount + 1>
		<cfset variables.xml.XmlRoot["test-results"].XmlAttributes["error-count"] = variables.errorCount>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="addFailure" returntype="void" access="public" output="false" hint="A failure occurred.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
		
		<cfset var currentTest = variables.currentTestData>
		<cfset var testNode = variables.currentTestNode>
		
		<cfset currentTest["hasFailure"] = TRUE>
		<cfset currentTest["failure"] = StructNew()>
		<cfset currentTest["failure"]["failureType"] = "Failure">
		<cfset currentTest["failure"]["exception"] = arguments.failure>
		
		<cfset testNode["failure"] = XmlElemNew(variables.xml, "failure")>
		<cfset testNode["failure"].XmlAttributes["exception"] = arguments.failure.type>
		<cfset testNode["failure"].XmlAttributes["message"] = arguments.failure.message>

		<cfset variables.failureCount = variables.failureCount + 1>
		<cfset variables.xml.XmlRoot["test-results"].XmlAttributes["failure-count"] = variables.failureCount>
		
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="endTest" returntype="void" access="public" output="false" hint="A test ended.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>

		<cfset var currentTest = variables.currentTestData>
		<cfset var testNode = variables.currentTestNode>
		
		<cfset currentTest["endTime"] = GetTickCount()>
		<cfset currentTest["executionTime"] = Abs(currentTest.endTime - currentTest.startTime)>

		<cfset testNode.XmlAttributes["execution-time"] = currentTest.executionTime>

		<cfif currentTest.hasFailure>
			<cfset testNode.XmlAttributes["status"] = currentTest.failure.failureType>
		<cfelse>
			<cfset testNode.XmlAttributes["status"] = "Success">
		</cfif>
		
		<cfset ArrayAppend(xml.XmlRoot["test-results"]["tests"].XmlChildren, testNode)>
		
		<cfset variables.testCount = variables.testCount + 1>
		<cfset variables.xml.XmlRoot["test-results"].XmlAttributes["test-count"] = variables.testCount>
		
		<cfset variables.currentTestData = "">
		<cfset variables.currentTestNode = "">
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="startTest" returntype="void" access="public" output="false" hint="A test started.">
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>

		<cfset var currentTest = StructNew()>
		<cfset var testNode = "">

		<cfset currentTest["testName"] = arguments.test.getName()>
		<cfset currentTest["test"] = arguments.test.toStringValue()>
		<cfset currentTest["startTime"] = GetTickCount()>
		<cfset currentTest["hasFailure"] = FALSE>
		
		<cfset testNode = XmlElemNew(variables.xml, "test")>
		<cfset testNode.XmlAttributes["test-suite"] = ListLast(currentTest.test, "()")>
		<cfset testNode.XmlAttributes["test-case-component"] = ListLast(currentTest.test, "().")>
		<cfset testNode.XmlAttributes["test-case-name"] = currentTest.testName>

		<cfset variables.currentTestData = currentTest>
		<cfset variables.currentTestNode = testNode>
	</cffunction>
	
	<!----------------------------------------------------------------------->

</cfcomponent>