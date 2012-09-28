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

<cfcomponent name="IMoney" extends="org.cfcunit.Object" output="false" hint="The common interface for simple Monies and MoneyBags">

	<!----------------------------------------------------------------------------->

	<cffunction name="add" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Adds a money to this money.">
		<cfargument name="m" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="addMoney" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Adds a simple Money to this money. This is a helper method for implementing double dispatch.">
		<cfargument name="m" type="org.cfcunit.samples.money.Money" required="true" hint=""/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="addMoneyBag" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Adds a MoneyBag to this money. This is a helper method for implementing double dispatch">
		<cfargument name="s" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="isZero" returntype="boolean" access="public" output="false" hint="Tests whether this money is zero.">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="multiply" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Multiplies a money by the given factor.">
		<cfargument name="factor" type="numeric" required="true" hint=""/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="negate" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Negates this money.">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="subtract" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Subtracts a money from this money.">
		<cfargument name="m" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="appendTo" returntype="void" access="public" output="false" hint="Append this to a MoneyBag m.">
		<cfargument name="m" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->

</cfcomponent>