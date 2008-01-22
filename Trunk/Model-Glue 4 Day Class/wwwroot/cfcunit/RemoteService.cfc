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

<!---
$Id: RemoteService.cfc,v 1.5 2006/12/20 07:03:38 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/RemoteService.cfc,v $
--->

<cfcomponent name="RemoteService" output="false" 
	hint="
			This service is only good for Flash Remoting and HTTP GET invocation at this point. For 
			some reason it does not work when called using SOAP WebServices or HTTP POST.
		">

	<!--------------------------------------------------------------------->
	
	<cfset init()>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="init" returntype="RemoteService" access="private" output="false">
		<cfset var resultBuilder = CreateObject("component", "cfcunit.service.util.TestResultBuilder").init()>
		<cfset var resultHandler = CreateObject("component", "cfcunit.service.results.ObjectResultHandler").init(resultBuilder)>
		<cfset var errorHelper = createObject("component", "org.cfcunit.service.ErrorHelper").init()>
		<cfset var listener = CreateObject("component", "org.cfcunit.service.TestListener").init(errorHelper)>
		
		<cfset variables.service = CreateObject("component", "cfcunit.service.TestingService").init(resultHandler)>
		
		<cfset variables.service.setListener(listener)>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="cfcunit.service.types.AllResults" access="remote" output="false">
		<cfargument name="testClassName" type="string" required="true" hint="Name of a TestCase/TestSuite subclass."/>

		<cfset var results = variables.service.runTest(arguments.testClassName)>

		<!--- This block is for when the service is called via a HTTP GET operation. --->
		<cfif reFindNoCase("/cfcunit/RemoteService\.cfc$", cgi.script_name) AND NOT compare("GET", cgi.request_method)>
			<cfcontent reset="true" type="application/xml"/>
		</cfif>

		<cfreturn results/>
	</cffunction>
	
	<!--------------------------------------------------------------------->

</cfcomponent>