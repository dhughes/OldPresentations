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
	<cfset testResults = event.getArg("testResults")>
	<cfset allErrors = listener.getErrors()>
</cfsilent>

<!----------------------------------------------------->

<cfif ArrayLen(allErrors)>
	<cfoutput>
	<table cellspacing="0" class="allErrors">
		<caption align="top">
			<h3><a name="allErrors">Test Errors</a></h3>
		</caption>
		
		<cfloop index="i" from="1" to="#ArrayLen(allErrors)#">
			<cfset currentError = allErrors[i]>
			<tr class="testSuite"><td colspan="2"><a style="float:left; display:block" name="a#Hash(currentError.test)#">#ListFirst(ListRest(currentError.test, "("), ")")#</a><div style="float:right"><a href="##top">Top</a></div></td></tr>
			
			<tr class="testCase">
				<th scope="row">TestCase</th>
				<td>#currentError.testName#&nbsp;</td>
			</tr>
			
			<cfif currentError.exception.type IS "database">
				<cfinclude template="/cfcunit/app/machii/views/tests/htmlui/errors/database.cfm"/>
			<cfelse>
				<cfinclude template="/cfcunit/app/machii/views/tests/htmlui/errors/default.cfm"/>
			</cfif>

			<cfif i LT ArrayLen(allErrors)>
				<tr class="space"><td colspan="2">&nbsp;</td></tr>
			</cfif>
		</cfloop>
	</table>
	</cfoutput>
</cfif>
