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

<cfparam name="currentError" type="struct"/>

<cfoutput>
<tr class="message">
	<th scope="row">Message</th>
	<td><cftry>#ReplaceList(currentError.exceptionInfo.message, "<,>", "&lt;,&gt;")#<cfcatch type="any"></cfcatch></cftry>&nbsp;</td>
</tr>

<tr class="detail">
	<th scope="row">Detail</th>
	<td>#currentError.exceptionInfo.detail#&nbsp;</td>
</tr>

<tr class="javaException">
	<th scope="row">Java Exception</th>
	<td>#currentError.exceptionInfo.name#</td>
</tr>

<tr class="cfException">
	<th scope="row">CF Exception</th>
	<td>#currentError.exception.type#</td>
</tr>

<tr class="stackTrace">
	<th scope="row">StackTrace</th>
	<td>
		<ol>
			<cfloop index="j" from="1" to="#ArrayLen(currentError.exceptionInfo.stackTrace)#">
				<cfset curItem = currentError.exceptionInfo.stackTrace[j]>
				<li>#curItem.filename#<cfif StructKeyExists(curItem, "udfName")>::#curItem.udfName#</cfif> (#curItem.lineNumber#)</li>
			</cfloop>
		</ol>
	</td>
</tr>
</cfoutput>