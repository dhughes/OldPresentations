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
	<cfswitch expression="#ThisTag.ExecutionMode#">
		
		<!-------------------------------------------------------------->
		
		<cfcase value="start">
			<cfparam name="attributes.pageData" type="variablename" default="stPage"/>
			
			<cfparam name="caller.viewData" type="struct" default="#StructNew()#"/>
			<cfparam name="caller.viewData.title" type="string" default=""/>
			
			<cfif NOT StructKeyExists(caller.viewdata, "htmlhead")>
				<cfset caller.viewData.htmlhead = CreateObject("component", "HtmlHead").init()>
			</cfif>
	
			<cfset caller[attributes.pageData] = caller.viewData>
		</cfcase>
		
		<!-------------------------------------------------------------->
		
		<cfcase value="end">
			<cfset content = thisTag.generatedContent>
			
			<cfsavecontent variable="content">
				<cfoutput>
				<?xml version="1.0" encoding="iso-8859-1"?>
				
				<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				
				<html xmlns="http://www.w3.org/1999/xhtml">
				
				<head>
					<title>#caller.viewData.title#</title>
					<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
					
					<link href="assets/styles/default.css" rel="stylesheet" type="text/css" />
					
					<cfloop index="i" from="1" to="#caller.viewdata.htmlhead.size()#">
						#caller.viewdata.htmlhead.getContent(i)#
					</cfloop>
				</head>
				
				<body>
				#content#
				</body>
				</html>
				</cfoutput>
			</cfsavecontent>
			
			<cfset thisTag.generatedContent = content>
		</cfcase>
		
		<!-------------------------------------------------------------->
	
	</cfswitch>
</cfsilent>