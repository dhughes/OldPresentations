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

<cfcomponent displayname="WasRun" extends="org.cfcunit.framework.TestCase" output="false" 
	hint="A helper test case for testing whether the testing method is run.">
	
	<!-------------------------------------------------------------------->
	
	<cfproperty name="fWasRun" type="boolean" hint="" default="false"/>
	
	<cfset this.fWasRun = FALSE>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="runTest" returntype="void" access="public" output="false">
		<cfset this.fWasRun = TRUE>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
</cfcomponent>