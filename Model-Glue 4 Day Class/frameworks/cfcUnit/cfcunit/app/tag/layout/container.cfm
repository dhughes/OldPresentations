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
	<cfparam name="attributes.title" type="string"/>
	<cfparam name="attributes.id" type="string" default=""/>
	<cfparam name="attributes.class" type="string" default=""/>
	<cfparam name="attributes.style" type="string" default=""/>
	<cfparam name="attributes.onClick" type="string" default=""/>
	
	<!------------------------------------------------------>
	
	<cfswitch expression="#thisTag.executionMode#">
		<!------------------------------------------------------>
		
		<cfcase value="start">
			<cfif NOT Len(attributes.title)>
				<cfthrow type="Exception.ZeroLengthString" message="Attribute TITLE is a zero-length string."/>
			</cfif>
			
			<cfif Len(attributes.class)>
				<cfset attributes.class = ListChangeDelims(attributes.class, " ", ",; ")>
			</cfif>
			
			<cfset attrID = IIF(Len(attributes.id), DE(' id="##attributes.id##"'), '""')>
			<cfset attrClass = IIF(Len(attributes.class), DE(' class="##attributes.class##"'), '""')>
			<cfset attrStyle = IIF(Len(attributes.style), DE(' style="##attributes.style##"'), '""')>
			<cfset attrOnClick = IIF(Len(attributes.onClick), DE(' onclick="##attributes.onClick##"'), '""')>
			<cfset attrAll = attrID & attrClass & attrStyle>
		</cfcase>
		
		<!------------------------------------------------------>
		
		<cfcase value="end">
			<cfoutput>
			<cfsavecontent variable="thisTag.generatedContent">
				<fieldset #attrAll#>
					<legend #attrOnClick#>&nbsp;<strong>#attributes.title#</strong>&nbsp;</legend>
					#thisTag.generatedContent#
				</fieldset>
			</cfsavecontent>
			</cfoutput>
		</cfcase>
		
		<!------------------------------------------------------>
	</cfswitch>
	
	<!------------------------------------------------------>
</cfsilent>