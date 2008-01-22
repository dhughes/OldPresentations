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

<cfcomponent name="XmlResultHandler" extends="org.cfcunit.service.ResultHandler" output="false">

	<!--------------------------------------------------------------------->
	
	<cfproperty name="xmlPrinter" type="cfcunit.service.util.XmlResultPrinter"/>
	<cfproperty name="testClassName" type="string"/>
	<cfproperty name="results" type="any"/>
	
	<!--------------------------------------------------------------------->

	<cffunction name="init" returntype="XmlResultHandler" access="public" output="false">
		<cfargument name="xmlPrinter" type="cfcunit.service.util.XmlResultPrinter" required="true"/>
		
		<cfset variables.xmlPrinter = arguments.xmlPrinter>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="getResults" returntype="any" access="public" output="false">
		<cfreturn variables.results/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onStart" returntype="void" access="public" output="false">
		<cfargument name="testClassName" type="string" required="true"/>

		<cfset var xml = XmlNew(true)>

		<cfset xml.XmlRoot = XmlElemNew(xml, "cfcUnit")>
		<cfset xml.XmlRoot.XmlAttributes["test-case"] = arguments.testClassName>
		<cfset xml.XmlRoot.XmlAttributes["status"] = "">
		<cfset xml.XmlRoot["test-results"] = XmlElemNew(xml, "test-results")>
		<cfset xml.XmlRoot["test-results"].XmlAttributes["test-count"] = "0">
		<cfset xml.XmlRoot["test-results"].XmlAttributes["failure-count"] = "0">
		<cfset xml.XmlRoot["test-results"].XmlAttributes["error-count"] = "0">
		<cfset xml.XmlRoot["test-results"]["tests"] = XmlElemNew(xml, "tests")>
				
		<cfset variables.testClassName = arguments.testClassName>
		<cfset variables.results = xml>
		
		<cfset variables.xmlPrinter.setXml(variables.results)>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onSuccess" returntype="void" access="public" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="true" hint=""/>
		<cfargument name="runner" type="org.cfcunit.service.TestRunner" required="true" hint=""/>
		
		<cfset var xml = variables.results>
		
		<cfset xml.XmlRoot.XmlAttributes["status"] = "Success">
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="onError" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset var xml = variables.results>
		
		<cfset xml.XmlRoot.XmlAttributes["status"] = "Error">
		<cfset xml.XmlRoot["error"] = XmlElemNew(xml, "error")>
		<cfset xml.XmlRoot["error"]["message"] = XmlElemNew(xml, "message")>
		<cfset xml.XmlRoot["error"]["message"].XmlText = "Test runner exited with unspecified error.">
	</cffunction>
	
	<!--------------------------------------------------------------------->

	<cffunction name="onFailure" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset var xml = variables.results>
		
		<cfset xml.XmlRoot.XmlAttributes["status"] = "Failure">
		<cfset xml.XmlRoot["failure"] = XmlElemNew(xml, "failure")>
		<cfset xml.XmlRoot["failure"]["error-code"] = XmlElemNew(xml, "error-code")>
		<cfset xml.XmlRoot["failure"]["error-code"].XmlText = arguments.exception.errorCode>
		<cfset xml.XmlRoot["failure"]["message"] = XmlElemNew(xml, "message")>
		<cfset xml.XmlRoot["failure"]["message"].XmlText = arguments.exception.message>
		<cfset xml.XmlRoot["failure"]["detail"] = XmlElemNew(xml, "detail")>
		<cfset xml.XmlRoot["failure"]["detail"].XmlText = arguments.exception.detail>
	</cffunction>
	
	<!--------------------------------------------------------------------->		

	<cffunction name="onException" returntype="void" access="public" output="false">
		<cfargument name="exception" type="any" required="true"/>
		
		<cfset var xml = variables.results>
		
		<cfset xml.XmlRoot.XmlAttributes["status"] = "Exception">
		<cfset xml.XmlRoot["exception"] = XmlElemNew(xml, "exception")>
		<cfset xml.XmlRoot["exception"]["message"] = XmlElemNew(xml, "message")>
		<cfset xml.XmlRoot["exception"]["message"].XmlText = "Test runner encounterd the an unhandled exception.">
		<cfset xml.XmlRoot["exception"]["stack-trace"] = XmlElemNew(xml, "stack-trace")>
		<cfset xml.XmlRoot["exception"]["stack-trace"].XmlText = arguments.exception.message>
	</cffunction>
	
	<!--------------------------------------------------------------------->

</cfcomponent>