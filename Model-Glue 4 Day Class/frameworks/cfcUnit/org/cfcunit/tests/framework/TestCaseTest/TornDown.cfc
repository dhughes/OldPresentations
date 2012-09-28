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

<cfcomponent displayname="TornDown" extends="org.cfcunit.framework.TestCase" output="false" hint="">
	
	<!------------------------------------------------------------------------------>
	
	<cfproperty name="fTornDown" type="boolean" default="false"/>
	
	<cfset this.fTornDown = FALSE>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="tearDown" returntype="void" access="public" output="false" 
		hint="Tears down the fixture, for example, close a network connection. This method is called after a test is executed.">
		
		<cfset this.fTornDown = TRUE>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="runTest" returntype="void" access="private" output="false" throws="Error" 
		hint="Override to run the test and assert its state.">
		
		<cfthrow type="Error"/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
</cfcomponent>