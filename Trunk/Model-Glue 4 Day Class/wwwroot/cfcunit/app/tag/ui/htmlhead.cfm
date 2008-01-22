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

<cfsilent>

<cfswitch expression="#thistag.executionMode#">

	<!--------------------------------------------------------------->
	
	<cfcase value="start">
		<cfparam name="attributes.value" type="string" default=""/>
		<cfparam name="attributes.id" type="string" default="#CreateUUID()#"/>
		
		<cfif NOT StructKeyExists(request, "cfcunit")>
			<cfset request.cfcunit.viewData.htmlhead = CreateObject("component", "HtmlHead").init()>
		<cfelseif NOT StructKeyExists(request.cfcunit, "viewdata")>
			<cfset request.cfcunit.viewData.htmlhead = CreateObject("component", "HtmlHead").init()>
		</cfif>
		<cfif NOT StructKeyExists(request.cfcunit.viewdata, "htmlhead")>
			<cfset request.cfcunit.viewData.htmlhead = CreateObject("component", "HtmlHead").init()>
		</cfif>
		
		<cfif Len(attributes.value)>
			<cfset request.cfcunit.viewdata.htmlhead.addContent(attributes.value, attributes.id)>
			<cfexit method="exittag"/>
		</cfif>
	</cfcase>
	
	<!--------------------------------------------------------------->
	
	<cfcase value="end">
		<cfset attributes.value = thistag.generatedContent>
		<cfset thistag.generatedContent = "">
		<cfset request.cfcunit.viewdata.htmlhead.addContent(attributes.value, attributes.id)>
	</cfcase>
	
	<!--------------------------------------------------------------->
	
</cfswitch>
</cfsilent>