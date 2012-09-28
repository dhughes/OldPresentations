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

<cfcomponent name="MoneyBag" extends="org.cfcunit.samples.money.IMoney" output="false" 
	hint="
<p>
	A MoneyBag defers exchange rate conversions. For example adding 12 Swiss Francs to 
	14 US Dollars is represented as a bag containing the two Monies 12 CHF and 14 USD. 
	Adding another 10 Swiss francs gives a bag with 22 CHF and 14 USD. Due to the deferred 
	exchange rate conversion we can later value a MoneyBag with different exchange rates.
</p>
<p> 
	A MoneyBag is represented as a list of Monies and provides different constructors 
	to create a MoneyBag.
</p>">

	<!-------------------------------------------------------------->
	
	<cfproperty name="fMonies" type="array" hint=""/>
	
	<cfset variables.fMonies = NULL>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="init" returntype="MoneyBag" access="public" output="false" hint="">
		<cfset variables.fMonies = ArrayNew(1)>
	
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="create" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="m1" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>
		<cfargument name="m2" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>
		<!--- --->
		<cfset var result = newMoneyBag()>
		
		<cfset arguments.m1.appendTo(result)/>
		<cfset arguments.m2.appendTo(result)/>
		
		<cfreturn result.simplify()/>
	</cffunction>

	<!-------------------------------------------------------------->
	
	<cffunction name="add" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>
		
		<cfreturn arguments.m.addMoneyBag(this)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="addMoney" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.Money" required="true" hint=""/>
		
		<cfreturn create(arguments.m, this)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="addMoneyBag" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="s" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>
		
		<cfreturn create(arguments.s, this)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="appendBag" returntype="void" access="public" output="false" hint="">
		<cfargument name="aBag" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>
		<!--- --->
		<cfset var i = 0>

		<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
			<cfset appendMoney(variables.fMonies[i])/>
		</cfloop>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="appendMoney" returntype="void" access="public" output="false" hint="">
		<cfargument name="aMoney" type="org.cfcunit.samples.money.Money" required="true" hint=""/>
		<!--- --->
		<cfset var old = NULL>
		<cfset var sum = NULL>

		<cfif arguments.aMoney.isZero()>
			<cfreturn/>
		</cfif>
		
		<cftry>
			<cfset old = findMoney(arguments.aMoney.currency())>
			<cfset variables.fMonies.removeElement(old)>
			<cfset sum = old.add(arguments.aMoney)>
			<cfif sum.isZero()>
				<cfreturn/>
			</cfif>
			<cfset variables.fMonies.addElement(sum)>
			
			<cfcatch type="Exception.MoneyNotFound">
				<cfset ArrayAppend(variables.fMonies, arguments.aMoney)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="equalsObject" returntype="boolean" access="public" output="false" hint="">
		<cfargument name="object" type="WEB-INF.cftag.component" required="true" hint=""/>
		<!--- --->
		<cfset var aMoneyBag = NULL>
		<cfset var i = 0>
		<cfset var m = NULL>

		<cfif isZero()>
			<cfif isCFCType(arguments.object, "org.cfcunit.samples.money.IMoney")>
				<cfreturn arguments.object.isZero()/>
			</cfif>
		</cfif>
		
		<cfif isCFCType(arguments.object, "org.cfcunit.samples.money.MoneyBag")>
			<cfset aMoneyBag = arguments.object>
			<cfif ArrayLen(aMoneyBag.getMonies()) NEQ ArrayLen(variables.fMonies)>
				<cfreturn FALSE/>
			</cfif>
			
			<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
				<cfset m = variables.fMonies[i]>
				<cfif NOT aMoneyBag.containsMoney(m)>
					<cfreturn FALSE/>
				</cfif>
			</cfloop>
			
			<cfreturn TRUE/>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="getHashCode" returntype="string" access="public" output="false" hint="">
		<cfset var hashValue = 0>
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
			<cfset hashValue = BitXOR(hashValue, variables.fMonies[i].getHashCode().hash())>
		</cfloop>
		
		<cfreturn Hash(hashValue)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="isZero" returntype="boolean" access="public" output="false" hint="">
		<cfreturn ArrayIsEmpty(variables.fMonies)/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="multiply" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="factor" type="numeric" required="true" hint=""/>
		<!--- --->
		<cfset var result = newMoneyBag()>
		<cfset var i = 0>
		
		<cfif arguments.factor NEQ 0>
			<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
				<cfset result.appendMoney(variables.fMonies[i].multiply(arguments.factor))>
			</cfloop>
		</cfif>
		
		<cfreturn result/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="negate" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfset var result = newMoneyBag()>
		<cfset var i = 0>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
			<cfset result.appendMoney(variables.fMonies[i].negate())>
		</cfloop>
		
		<cfreturn result/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="subtract" returntype="org.cfcunit.samples.money.IMoney" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.IMoney" required="true" hint=""/>

		<cfreturn add(arguments.m.negate())/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false" hint="">
		<cfset var i = 0>
		<cfset var strVal = NULL>

		<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
			<cfset strVal = strVal & variables.fMonies[i].toStringValue()>
		</cfloop>
		
		<cfreturn "{#strVal#}"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="appendTo" returntype="void" access="public" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.MoneyBag" required="true" hint=""/>
		
		<cfset arguments.appendBag(this)>
	</cffunction>
	
	<!-------------------------------------------------------------->
	<!-------------------------------------------------------------->

	<cffunction name="getMonies" returntype="array" access="package" output="false" hint="">
		<cfreturn variables.fMonies/>
	</cffunction>
	
	<!-------------------------------------------------------------->

	<cffunction name="simplify" returntype="org.cfcunit.samples.money.IMoney" access="package" output="false" hint="">
		<cfif ArrayLen(variables.fMonies) IS 1>
			<cfreturn variables.fMonies[1]/>
		</cfif>
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	<!-------------------------------------------------------------->

	<cffunction name="findMoney" returntype="org.cfcunit.samples.money.Money" access="private" output="false" hint="" throws="Exception.MoneyNotFound">
		<cfargument name="currency" type="string" required="true" hint=""/>
		<!--- --->
		<cfset var i = 0>
		<cfset var m = NULL>
		
		<cfloop index="i" from="1" to="#ArrayLen(variables.fMonies)#">
			<cfset m = variables.fMonies[i]>
			<cfif NOT Compare(m.currency(), arguments.currency)>
				<cfreturn m/>
			</cfif>
		</cfloop>
		
		<cfthrow type="Exception.MoneyNotFound"/>
	</cffunction>
	
	<!----------------------------------------------------------------------------->
	
	<cffunction name="containsMoney" returntype="boolean" access="private" output="false" hint="">
		<cfargument name="m" type="org.cfcunit.samples.money.Money" required="true" hint=""/>
		<!--- --->
		<cfset var found = NULL>
		
		<cftry>
			<cfset found = findMoney(arguments.m.currency())>
			<cfif found.amount() IS arguments.m.amount()>
				<cfreturn TRUE/>
			</cfif>
			
			<cfcatch type="Exception.MoneyNotFound">
				<cfreturn FALSE/>
			</cfcatch>
		</cftry>

		<cfreturn FALSE/>
	</cffunction>
	
	<!-------------------------------------------------------------->
	
	<cffunction name="newMoneyBag" returntype="org.cfcunit.samples.money.MoneyBag" access="private" output="false" hint="">
		<cfreturn newObject("org.cfcunit.samples.money.MoneyBag").init()/>
	</cffunction>
	
	<!-------------------------------------------------------------->

</cfcomponent>