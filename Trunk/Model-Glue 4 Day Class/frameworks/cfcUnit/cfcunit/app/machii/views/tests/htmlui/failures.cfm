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
	<cfparam name="event" type="struct"/>
	
	<cfset listener = event.getArg("listener")>
	<cfset allFailures = listener.getFailures()>
</cfsilent>

<!----------------------------------------------------->

<cfif ArrayLen(allFailures)>
	<cfoutput>
	<table cellspacing="0" class="allFailures">
		<caption align="top">
			<h3><a name="allFailures">Test Failures</a></h3>
		</caption>
		
		<cfloop index="i" from="1" to="#ArrayLen(allFailures)#">
			<cfset currentFailure = allFailures[i]>
			
			<tr class="testSuite"><td colspan="2"><a style="display:block; float:left" name="a#Hash(currentFailure.test)#">#ListFirst(ListRest(currentFailure.test, "("), ")")#</a><div style="float:right"><a href="##top">Top</a></div></td></tr>
			<tr class="testCase">
				<th scope="row">TestCase</th>
				<td>#currentFailure.testName#</td>
			</tr>
			<tr class="exception">
				<th scope="row">Exception</th>
				<td>#currentFailure.exception.type#</td>
			</tr>
			<tr class="message">
				<th scope="row">Message</th>
				<td>#ReplaceList(currentFailure.exception.message, "<,>", "&lt;,&gt;")#</td>
			</tr>
			
			<cfif i LT ArrayLen(allFailures)>
				<tr class="space"><td colspan="2">&nbsp;</td></tr>
			</cfif>
		</cfloop>
	</table>
	</cfoutput>
</cfif>