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
$Id: DatabaseError.cfc,v 1.2 2006/11/21 20:49:40 paulkenney Exp $
$Source: /cvsroot/openxcf/cfcUnit/cfcunit/service/types/errors/DatabaseError.cfc,v $
--->

<cfcomponent name="DatabaseError" output="false" hint="">

	<cfproperty name="datasource"		type="string"	hint=""/>
	<cfproperty name="nativeErrorCode"	type="string"	hint=""/>
	<cfproperty name="sqlState"			type="string"	hint=""/>
	<cfproperty name="sqlStatement"		type="string"	hint=""/>
	<cfproperty name="bindParameters"	type="array"	hint="BindParameter[]" required="true"/>
	
	<cfset this.datasource = "">
	<cfset this.nativeErrorCode = "">
	<cfset this.sqlState = "">
	<cfset this.sqlStatement = "">
	<cfset this.bindParameters = ArrayNew(1)>
	
</cfcomponent>