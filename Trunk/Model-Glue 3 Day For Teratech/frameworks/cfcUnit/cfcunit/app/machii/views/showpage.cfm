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
	<cfparam name="request.event" type="struct"/>
	<cfset viewData = request.event.getArg("viewData", StructNew())>
	<cfsetting showdebugoutput="false"/>
</cfsilent>

<!----------------------------------------------------->

<cfoutput>
<cfmodule template="/cfcunit/app/tag/ui/page.cfm" pagedata="stPage">
	<cfparam name="stPage.title" type="string" default="CFCUnit Test Application"/>
	<cfparam name="stPage.pageContent" type="string" default=""/>

	<div id="header">
		<h1>cfcUnit</h1>
		<h2>ColdFusion Unit Testing Framework</h2>
	</div>
	
	<div id="pageContent">
		#stPage.pageContent#
	</div>
</cfmodule>
</cfoutput>