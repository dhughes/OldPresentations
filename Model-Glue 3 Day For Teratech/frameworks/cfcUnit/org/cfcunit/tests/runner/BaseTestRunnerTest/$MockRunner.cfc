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

<cfcomponent displayname="MockRunner" extends="org.cfcunit.runner.BaseTestRunner" output="false" hint="">
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="runFailed" returntype="void" access="private" output="false">
		<cfargument name="message" type="string" required="true"/>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testEnded" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testFailed" returntype="void" access="public" output="false">
		<cfargument name="status" type="numeric" required="true"/>
		<cfargument name="test" type="org.cfcunit.framework.Test" required="true"/>
		<cfargument name="failure" type="any" required="true"/>
	</cffunction>
	
	<!-------------------------------------------------------------------->
	
	<cffunction name="testStarted" returntype="void" access="public" output="false">
		<cfargument name="testName" type="string" required="true"/>
	</cffunction>
	
	<!-------------------------------------------------------------------->

</cfcomponent>