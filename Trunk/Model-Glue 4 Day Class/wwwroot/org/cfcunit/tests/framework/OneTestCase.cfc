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

<cfcomponent displayname="OneTestCase" extends="org.cfcunit.framework.TestCase" output="false" 
	hint="Test class used in SuiteTest">

	<cffunction name="noTestCase" returntype="void" access="public" output="false">
	</cffunction>
	
	<cffunction name="testCase" returntype="void" access="public" output="false">
		<cfargument name="arg" type="numeric" required="false"/>
	</cffunction>
	
</cfcomponent>