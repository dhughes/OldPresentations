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

<cfcomponent name="Money" extends="org.cfcunit.samples.money.IMoney" output="false" hint="A simple Money.">

	<!-------------------------------------------------------------->
	
	<cfproperty name="MoneyBag" type="org.cfcunit.samples.money.MoneyBag" hint=""/>
	<cfproperty name="fAmount" type="numeric" hint=""/>
	<cfproperty name="fCurrency" type="string" hint=""/>
	
	<cfset variables.MoneyBag = newObject("org.cfcunit.samples.money.MoneyBag")>
	<cfset variables.fAmount = NULL>
	<cfset variables.fCurrency = NULL>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="init" returntype="Money" access="public" output="false" hint="Constructs a money from the given amount and currency.">
		<cfargument name="amount" type="numeric" required="true" hint=""/>
		<cfargument name="currency" type="string" required="true" hint=""/>
		
		<cfset variables.fAmount = arguments.amount>
		<cfset variables.fCurrency = arguments.currency>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="add" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="Adds a money to this money. Forwards the request to the addMoney helper.">
		<cfargument name="m" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>

		<cfreturn arguments.m.addMoney(this)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="addMoney" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.Money" required="true" hint=""/>

		<cfif arguments.m.currency().isEqualTo(currency())>
			<cfreturn newMoney(amount()+arguments.m.amount(), currency())/>
		</cfif>
		
		<cfreturn variables.MoneyBag.create(this, arguments.m)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="addMoneyBag" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="s" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>

		<cfreturn arguments.s.addMoney(this)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="amount" returntype="numeric" access="public" output="false" hint="">
		<cfreturn variables.fAmount/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="currency" returntype="string" access="public" output="false" hint="">
		<cfreturn variables.fCurrency/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="equalsObject" returntype="boolean" access="public" output="false" hint="">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true" hint=""/>
		<!--- --->
		<cfset var money = arguments.object>
		
		<cfif isZero()>
			<cfif isCFCType(arguments.object, "org.cfcunit.samples.money.IMoney")>
				<cfreturn arguments.object.isZero()/>
			</cfif>
		</cfif>
		
		<cfif isCFCType(arguments.object, "org.cfcunit.samples.money.Money")>
			<cfreturn money.currency().equalsObject(currency()) AND amount() IS money.amount()/>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->

	<cffunction name="getHashCode" returntype="string" access="public" output="false" hint="">
		<cfreturn Hash(variables.fCurrency.hashCode & variables.fAmount)/>
	</cffunction>

	<!----------------------------------------------------------------------------->
	
	<cffunction name="isZero" returntype="boolean" access="public" output="false" hint="">
		<cfreturn amount() IS 0/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="multiply" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="factor" type="numeric" required="true" hint=""/>
		
		<cfreturn newMoney(amount()*arguments.factor, currency())/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="negate" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfreturn newMoney(-1*amount(), currency())/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="subtract" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>

		<cfreturn add(arguments.m.negate())/>
	</cffunction>
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false" hint="">
		<cfreturn "[" & amount() & " " & currency() & "]"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="appendTo" returntype="void" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>

		<cfset arguments.m.appendMoney(this)/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	<!-------------------------------------------------------------->

	<cffunction name="newMoney" returntype="org.cfcunit.samples.money.Money" access="private" output="false" hint="">
		<cfargument name="amount" type="numeric" required="true" hint=""/>
		<cfargument name="currency" type="string" required="true" hint=""/>
		<!--- --->
		<cfset var money = newObject("org.cfcunit.samples.money.Money")>
		
		<cfreturn money.init(arguments.amount, arguments.currency)/>
	</cffunction>

	<!-------------------------------------------------------------->

</cfcomponent>