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

<cfparam name="request.message" type="string"/>
<cfparam name="request.missingFields" type="string"/>

<cfoutput>
<div>
	<h3>#request.message#</h3>
	
	<strong>Missing Fields:</strong>
	<ul>
		<cfloop list="#request.missingFields#" index="fieldName">
			<li>#fieldName#</li>
		</cfloop>
	</ul>
</div>
</cfoutput>