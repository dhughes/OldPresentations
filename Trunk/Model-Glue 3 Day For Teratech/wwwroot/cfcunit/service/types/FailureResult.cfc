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
$Id: FailureResult.cfc,v 1.2 2006/11/21 20:49:41 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/types/FailureResult.cfc,v $
--->

<cfcomponent name="FailureResult" output="false" hint="">

	<!---------------------------------------------------------------------->
	
	<cfproperty name="errorCode"	type="string" hint=""/>
	<cfproperty name="message"		type="string" hint=""/>
	<cfproperty name="detail"		type="string" hint=""/>
	
	<cfset this.errorCode = "">
	<cfset this.message = "">
	<cfset this.detail = "">
	
	<!---------------------------------------------------------------------->

</cfcomponent>