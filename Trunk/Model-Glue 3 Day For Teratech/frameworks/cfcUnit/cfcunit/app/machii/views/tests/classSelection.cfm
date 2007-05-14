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
$Id: classSelection.cfm,v 1.5 2006/12/16 10:07:51 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/app/machii/views/tests/classSelection.cfm,v $
--->

<cfsilent>
	<cfparam name="event" type="struct"/>
	
	<cfset testClassName = event.getArg("testClassName", "")>
	<cfset runnerType = event.getArg("runnerType", "html")>
	<cfset showDebug = event.getArg("showDebug", "false")>
	<cfset showTestArgs = event.getArg("showTestArgs", false)>
	<cfset testClassArgs = event.getArg("testClassArgs", "")>
	
	<cftry>
		<cfparam name="showDebug" type="boolean"/>
		
		<cfcatch type="any">
			<cfset showDebug = FALSE>
		</cfcatch>
	</cftry>
	
	<!---
	<cfif showTestArgs>
		<cfset parameterMetadata = event.getArg("parameterMetadata")>
	</cfif>
	--->
	
	<cfsetting showdebugoutput="#showDebug#"/>
</cfsilent>

<!----------------------------------------------------------->


<cfoutput>

<h3><label for="testClassName">Enter test to run:</label></h3>

<form action="index.cfm" method="get">

<input type="hidden" name="event" value="runTest" />

<div class="testClassInput">
	<!---<label for="testClassName">Test Class:</label><br />--->
	<input name="testClassName" id="testClassName" class="text" type="text" value="#testClassName#" /><br />

	<cfif showTestArgs>
		<label for="testClassArgs">Test Args:</label> 
		<input name="testClassArgs" id="testClassArgs" class="text" type="text" value="#testClassArgs#"/><br />
	</cfif>
</div>

<div class="runnerTypes">
	<input type="radio" name="runnerType" id="runnerTypeHTML" value="html" <cfif runnerType IS "html">checked="checked"</cfif>/>
	<label for="runnerTypeHTML">HTML Runner</label><br />

	<input type="radio" name="runnerType" id="runnerTypeText" value="text" <cfif runnerType IS "text">checked="checked"</cfif>/>
	<label for="runnerTypeText">Text Runner</label><br />
</div>

<div class="submitButtons">
	<button onclick="form.submit()">Run Test</button><br />
</div>

</form>
</cfoutput>