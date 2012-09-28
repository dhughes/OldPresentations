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

<cfparam name="url.testClassName" type="string"/>
<!---<cfparam name="url.parameters" type="string" default=""/>--->
<cfparam name="url.parameterformat" type="string" default="simple"/>

<cfset runTestArgs = structNew()>
<cfset runTestArgs["testClassName"] = url.TestClassName>

<cfif structKeyExists(url, "parameters") and len(url.parameters)>
	<cfswitch expression="#url.parameterformat#">
		<cfcase value="none">
			<cfset parameterCollection = createObject("component", "cfcunit.service.util.UnencodedParameters").init(url.parameters)>
			<cfset runTestArgs["parameters"] = parameterCollection>
		</cfcase>
		
		<cfcase value="simple">
			<cfset parameterCollection = createObject("component", "cfcunit.service.util.EncodedParameters").init(url.parameters)>
			<cfset runTestArgs["parameters"] = parameterCollection>
		</cfcase>
		
		<cfcase value="json">
			<cfset parameterCollection = createObject("component", "cfcunit.service.util.JSONEncodedParameters").init(url.parameters)>
			<cfset runTestArgs["parameters"] = parameterCollection>
		</cfcase>
	</cfswitch>
</cfif>

<cfset xmlPrinter = CreateObject("component", "cfcunit.service.util.XmlResultPrinter").init()>
<cfset resultHandler = CreateObject("component", "cfcunit.service.results.XmlResultHandler").init(xmlPrinter)>
<cfset service = CreateObject("component", "cfcunit.service.TestingService").init(resultHandler)>

<cfset service.setListener(xmlPrinter)>

<cfset results = service.runTest(argumentCollection=runTestArgs)>


<cfcontent reset="true" type="application/xml"/><cfoutput>#ToString(resultHandler.getResults())#</cfoutput>