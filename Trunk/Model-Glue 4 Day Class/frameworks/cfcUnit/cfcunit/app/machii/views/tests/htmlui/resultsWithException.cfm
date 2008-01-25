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
	
	<cfsavecontent variable="headStyle">
		<link href="assets/styles/htmlui.css" rel="stylesheet" type="text/css" />
	</cfsavecontent>
	<cfhtmlhead text="#headStyle#"/>
</cfsilent>

<!----------------------------------------------------->

<cfoutput>
<div class="htmlui">
	<h3>Test runner encounterd the an unchecked exception. Below is the stack trace:</h3>
	<pre>#event.getArg("stackTrace")#</pre>
</div>
</cfoutput>