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

<cfparam name="request.event" type="struct" />

<cfset exception = request.event.getArg("exception")>
<cfset exceptionEvent = request.event.getArg("exceptionEvent")>

<!--------------------------------------------------------------------->

<util:htmlhead key="exception">
	<link href="assets/styles/exception.css" rel="stylesheet" type="text/css" />
</util:htmlhead>

<!--------------------------------------------------------------------->

<cfoutput>
<fieldset class="exception">
	<legend>Exception</legend>
	<table>
		<tr valign="top">
			<td><label>Type:</label></td>
			<td>#exception.getType()#</td>
		</tr>
		<tr valign="top">
			<td><label>Message:</label></td>
			<td>#exception.getMessage()#</td>
		</tr>
		<tr valign="top">
			<td><label>Detail:</label></td>
			<td>#exception.getDetail()#</td>
		</tr>
		<tr valign="top">
			<td><label>Extended Info:</label></td>
			<td>#exception.getExtendedInfo()#</td>
		</tr>
		<tr valign="top">
			<td><label>Tag Context:</label></td>
			<td>
				<cfset tagCtxArr = exception.getTagContext() />
				<cfloop index="i" from="1" to="#ArrayLen(tagCtxArr)#">
					<cfset tagCtx = tagCtxArr[i] />
					#tagCtx['template']# (#tagCtx['line']#)<br>
				</cfloop>
			</td>
		</tr>
	</table>
</fieldset>
</cfoutput>