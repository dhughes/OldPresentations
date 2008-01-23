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
$Id: TestFailure.cfc,v 1.2 2006/11/21 20:49:41 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/types/TestFailure.cfc,v $
--->

<cfcomponent name="TestFailure" output="false" hint="">

	<cfproperty name="testCaseComponent"	type="string" hint=""/>
	<cfproperty name="testCaseName"			type="string" hint=""/>
	<cfproperty name="exception"			type="string" hint=""/>
	<cfproperty name="message"				type="string" hint=""/>
	
	<cfset this.testCaseComponent = "">
	<cfset this.testCaseName = "">
	<cfset this.exception = "">
	<cfset this.message = "">

</cfcomponent>