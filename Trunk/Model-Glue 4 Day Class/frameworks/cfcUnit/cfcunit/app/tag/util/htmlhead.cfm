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
	<cfswitch expression="#thisTag.executionMode#">
		<!------------------------------------------------------------------->
		
		<cfcase value="start">
			<cfparam name="attributes.key" type="string" default=""/>
			<cfparam name="attributes.throwOnDuplicateKey" type="boolean" default="false"/>
			
			<cfparam name="request.htmlhead" type="struct" default="#StructNew()#"/>
			
			<cfif NOT thisTag.hasEndTag>
				<cfthrow type="Exception.CustomTag" message="Tag CF_HTMLHEAD requires an end tag."/>
			</cfif>
			
			<cfif Len(attributes.key)>
				<cfif StructKeyExists(request.htmlhead, attributes.key)>
					<cfif attributes.throwOnDuplicateKey>
						<cfthrow type="Exception.HTMLHead" message="Content with key #attributes.key# is already defined."/>
					<cfelse>
						<cfexit method="exittag"/>
					</cfif>
				</cfif>
				<cfset request.htmlhead[attributes.key] = "">
			</cfif>
		</cfcase>
		
		<!------------------------------------------------------------------->
		
		<cfcase value="end">
			<cfset content = thisTag.generatedContent>
			<cfset thisTag.generatedContent = "">
			
			<cfif Len(attributes.key)>
				<cfset request.htmlhead[attributes.key] = content>
			</cfif>
			<cfhtmlhead text="#content#"/>
		</cfcase>
		
		<!------------------------------------------------------------------->
	</cfswitch>
</cfsilent>