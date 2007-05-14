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
$Id: AllResults.cfc,v 1.2 2006/11/21 20:49:41 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/types/AllResults.cfc,v $
--->

<cfcomponent name="AllResults" output="false" hint="">

	<!--------------------------------------------------------------------------->
	
	<cfproperty name="status"			type="string"			hint=""/>
	<cfproperty name="testResults"		type="TestResults"		hint="" required="false"/>
	<cfproperty name="errorResult"		type="ErrorResult"		hint="" required="false"/>
	<cfproperty name="failureResult"	type="FailureResult"	hint="" required="false"/>
	<cfproperty name="exceptionResult"	type="ExceptionResult"	hint="" required="false"/>

	<cfset this.status = "SUCCESS">
	
	<!--------------------------------------------------------------------------->

</cfcomponent>