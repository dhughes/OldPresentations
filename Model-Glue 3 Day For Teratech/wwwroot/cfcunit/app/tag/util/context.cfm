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
File: /cfcunit/_tag/context.cfm
Date: 07-18-2002
Programmer: Paul Kenney
Email: paul@pjk.us
--->

<cfsilent>

<cfif ThisTag.ExecutionMode IS "start">
	<cfparam name="Attributes.Name" type="string"/>
	<cfparam name="Attributes.bMangleName" type="boolean" default="true"/>
	<cfparam name="Attributes.Return" type="string" default=""/>
</cfif>

<!-------------------------------------------------------------------------------->

<cfset Attributes.Name = LCase(Attributes.Name)>
<cfset NULL = Chr(0)>

<!-------------------------------------------------------------------------------->

<cfif NOT ThisTag.HasEndTag>
	<cfthrow type="Exception.HasNoEndTag" message="CF_CONTEXT requires an end tag."/>
</cfif>

<!-------------------------------------------------------------------------------->

<cffunction name="getCurrentApplicationSettings" returntype="struct" output="false">
	<cfset var Factory = NULL>
	<cfset var Runtime = NULL>
	<cfset var Clients = NULL>
	<cfset var cfcatch = NULL>
	<cfset var aScopes = NULL>
	<cfset var stClient = NULL>
	<cfset var ret = StructNew()>
	
	<cflock name="cfadmin_runtime" type="readonly" timeout="20">
		<cfset Factory = CreateObject("java", "coldfusion.server.ServiceFactory")>
		<cfset Runtime = Factory.RuntimeService>
		<cfset Clients = Factory.ClientScopeService>
		
		<cfset ret.IsApplicationEnabled = IsDefined("Application")>
		<cfset ret.IsSessionEnabled = IsDefined("Session")>
		<cfset ret.IsClientEnabled = NOT CompareNoCase(getMetadata(Client).getName(), "coldfusion.runtime.ClientScope")>
		
		<cfif ret.IsApplicationEnabled>
			<cfset ret.ApplicationName = NULL>
			<cfif StructKeyExists(Application, "ApplicationName")>
				<cfset ret.ApplicationName = Application.ApplicationName>
			</cfif>
			<cfset ret.ApplicationTimeout = Runtime.getApplicationTimeout()>
			<cfset ret.MaxApplicationTimeout = Runtime.getApplicationMaxTimeout()>
		</cfif>
		
		<cfif ret.IsSessionEnabled>
			<cfset ret.SessionTimeout = Runtime.getSessionTimeout()>
			<cfset ret.MaxSessionTimeout = Runtime.getSessionMaxTimeout()>
		</cfif>
		
		<cfif ret.IsClientEnabled>
			<cfset ret.ClientStorage = Client.getPersistSettings().get("clientstorage")>
		</cfif>
	</cflock>
	
	<cfreturn ret/>
</cffunction>


<!-------------------------------------------------------------------------------->
<!-------------------------------------------------------------------------------->


<cfswitch expression="#ThisTag.ExecutionMode#">
	<!-------------------------------------------------------------------------------->
	
	<cfcase value="start">
		<cfif NOT Len(Attributes.Name)>
			<cfset Attributes.bMangleName = FALSE>
		</cfif>
		
		<cfif Attributes.bMangleName>
			<cfset Attributes.Name = ListChangeDelims(Attributes.Name, "$", ".")>
			<cfset Attributes.Name = "$context$" & Attributes.Name>
		</cfif>

		<cftry>
			<cfset ThisTag.AppSettings = getCurrentApplicationSettings()>
			<cfapplication name="#Attributes.Name#" sessionmanagement="true"/>
			
			<cfif Len(Attributes.Return)>
				<cfset ret = StructNew()>
				<cfset ret["Application"] = Application>
				<cfset ret["Session"] = Session>
				<cfset Caller[Attributes.Return] = ret>
			</cfif>
			
			<cfcatch type="any">
				<cfexit method="exittag"/>
			</cfcatch>
		</cftry>
	</cfcase>
	
	<!-------------------------------------------------------------------------------->

	<cfcase value="end">
		<cftry>
			<cfif ThisTag.AppSettings.IsApplicationEnabled>
				<cfif ThisTag.AppSettings.IsSessionEnabled>
					<cfif ThisTag.AppSettings.IsClientEnabled>
						<cfapplication name="#ThisTag.AppSettings.ApplicationName#" 
							clientmanagement="TRUE"
							clientstorage="#ThisTag.AppSettings.ClientStorage#"
							sessionmanagement="true"
							sessiontimeout="#CreateTimeSpan(0,0,0,ThisTag.AppSettings.SessionTimeout)#"
							applicationtimeout="#CreateTimeSpan(0,0,0,ThisTag.AppSettings.ApplicationTimeout)#">
					<cfelse>
						<cfapplication name="#ThisTag.AppSettings.ApplicationName#"
							clientmanagement="FALSE"
							sessionmanagement="TRUE"
							applicationtimeout="#CreateTimeSpan(0,0,0,ThisTag.AppSettings.ApplicationTimeout)#"
							sessiontimeout="#CreateTimeSpan(0,0,0,ThisTag.AppSettings.SessionTimeout)#">					
					</cfif>
				<cfelse>
					<cfif ThisTag.AppSettings.IsClientEnabled>
						<cfapplication name="#ThisTag.AppSettings.Name#"
							clientmanagement="TRUE"
							clientstorage="#ThisTag.AppSettings.ClientStorage#" 
							sessionmanagement="FALSE" 
							applicationtimeout="#CreateTimeSpan(0,0,0,ThisTag.AppSettings.ApplicationTimeout)#">					
					<cfelse>
						<cfapplication name="#ThisTag.AppSettings.Name#"
							clientmanagement="FALSE"
							sessionmanagement="FALSE"
							applicationtimeout="#CreateTimeSpan(0,0,0,ThisTag.AppSettings.ApplicationTimeout)#">										
					</cfif>
				</cfif>
			
			<cfelse>
				<cfapplication name="-" applicationtimeout="#CreateTimeSpan(0,0,0,0)#" sessionmanagement="false">
			</cfif>
			
			<cfcatch type="any">
				<cfapplication name="-" applicationtimeout="#CreateTimeSpan(0,0,0,0)#" sessionmanagement="false">
			</cfcatch>
		</cftry>
		<cfexit method="exittag"/>
	</cfcase>

	<!-------------------------------------------------------------------------------->
</cfswitch>

</cfsilent>