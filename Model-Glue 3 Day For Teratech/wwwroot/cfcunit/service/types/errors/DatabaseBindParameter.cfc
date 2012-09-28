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
$Id: DatabaseBindParameter.cfc,v 1.2 2006/11/21 20:49:40 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/types/errors/DatabaseBindParameter.cfc,v $
--->

<cfcomponent name="DatabaseBindParameter" output="false" hint="">

	<cfproperty name="param"	type="numeric"	hint=""/>
	<cfproperty name="type"		type="string"	hint=""/>
	<cfproperty name="sqlType"	type="string"	hint=""/>
	<cfproperty name="class"	type="string"	hint=""/>
	<cfproperty name="value"	type="string"	hint=""/>
	
	<cfset this.param = 0>
	<cfset this.type = "">
	<cfset this.sqlType = "">
	<cfset this.class = "">
	<cfset this.value = "">

</cfcomponent>