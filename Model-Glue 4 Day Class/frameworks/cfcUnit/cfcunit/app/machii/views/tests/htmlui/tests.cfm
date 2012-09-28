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
	
	<cfset allTests = listener.getTests()>
	<cfset allFailures = listener.getFailures()>
	<cfset allErrors = listener.getErrors()>
	
	<cfset iconDirectory = "assets/images/icons">
	
	<cfif testResults.wasSuccessful()>
		<cfset allTestsMessage = "All Passed!">
	<cfelse>
		<cfset allTestsMessage = "Tests Failed!">
	</cfif>

</cfsilent>

<!----------------------------------------------------->

<cfoutput>
<table cellspacing="0" class="allTests">
	<caption align="top">
		<h3><a name="allTests">Test Results: #allTestsMessage#</a></h3>
		
		<ul>
			<li><a href="##allTests"><strong>Tests:</strong> #testResults.runCount()#</a></li>
			<li><a href="##allFailures"><strong>Failures:</strong> #testResults.failureCount()#</a></li>
			<li><a href="##allErrors"><strong>Errors:</strong> #testResults.errorCount()#</a></li>
		</ul>
		
		<!--- 10/31/2005 - Added by Chris Scott to fix formatting in Safari browser. --->
		<div class="clearer">&nbsp;</div>
	</caption>

	<tr>
		<th class="testCase">TestCase</th>
		<th class="testName">TestName</th>
		<th class="executionTime">Time</th>
		<th colspan="2" class="status">Status</th>
		<th class="message">Message</th>
	</tr>
	
	<cfset currentTestName = "">
	
	<cfloop index="i" from="1" to="#ArrayLen(allTests)#">
		<cfsilent>
			<cfset currentTest = allTests[i]>
	
			<cfif currentTest.hasFailure>
				<cfset currentStatus = currentTest.failure.failureType>
				<cfset currentMessage = currentTest.failure.exception.Message>
				<cfset iconFilename = LCase(currentStatus) & ".gif">
			<cfelse>
				<cfset currentStatus = "Success">
				<cfset currentMessage = "">
				<cfset iconFilename = "ok.gif">
			</cfif>
			<cfset currentTestCase = ListLast(currentTest.test, "().")>
			<cfset currentIconPath = "#iconDirectory#/#iconFilename#">
		</cfsilent>
		
		<cfif currentTestName NEQ currentTestCase>
			<cfset currentTestName = currentTestCase>
			<tr class="testSuite"><td colspan="6">#ListChangeDelims(ListRest(currentTest.test, "("), "", ")")#</td></tr>
		</cfif>
		
		<cfif currentStatus IS "Success">
			<tr class="#LCase(currentStatus)#">
				<td class="testCase">#currentTestCase#</td>
				<td class="testName">#currentTest.testName#</td>
				<td class="executionTime">#currentTest.executionTime#ms</td>
				<td class="status">#currentStatus#</td>
				<td class="icon"><img src="#currentIconPath#" class="icon" alt="#currentStatus#" /></td>
				<td class="errorMessage">#currentMessage#&nbsp;</td>
			</tr>
		<cfelse>
			<tr class="#LCase(currentStatus)#">
				<td class="testCase"><a href="##a#Hash(currentTest.test)#">#currentTestCase#</a></td>
				<td class="testName"><a href="##a#Hash(currentTest.test)#">#currentTest.testName#</a></td>
				<td class="executionTime"><a href="##a#Hash(currentTest.test)#">#currentTest.executionTime#ms</a></td>
				<td class="status"><a href="##a#Hash(currentTest.test)#">#currentStatus#</a></td>
				<td class="icon"><a href="##a#Hash(currentTest.test)#"><img src="#currentIconPath#" class="icon" alt="#currentStatus#" /></a></td>
				<td class="errorMessage"><a href="##a#Hash(currentTest.test)#">#ReplaceList(currentMessage, "<,>", "&lt;,&gt;")#</a>&nbsp;</td>
			</tr>
		</cfif>
	</cfloop>
</table>
</cfoutput>