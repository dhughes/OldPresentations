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

<cfcomponent name="EmptyTest" extends="org.cfcunit.framework.TestCase" output="false" hint="">

	<!--------------------------------------------------------------->
	
	<cfproperty name="MoneyBag" type="org.cfcunit.samples.money.MoneyBag" hint=""/>
	<cfproperty name="f12CHF" type="org.cfcunit.samples.money.Money" hint=""/>
	<cfproperty name="f14CHF" type="org.cfcunit.samples.money.Money" hint=""/>
	<cfproperty name="f7USD" type="org.cfcunit.samples.money.Money" hint=""/>
	<cfproperty name="f21USD" type="org.cfcunit.samples.money.Money" hint=""/>
	<cfproperty name="fMB1" type="org.cfcunit.samples.money.IMoney" hint=""/>
	<cfproperty name="fMB2" type="org.cfcunit.samples.money.IMoney" hint=""/>

	<cfset variables.MoneyBag = newObject("org.cfcunit.samples.money.MoneyBag")>
	<cfset variables.f12CHF = NULL>
	<cfset variables.f14CHF = NULL>
	<cfset variables.f7USD = NULL>
	<cfset variables.f21USD = NULL>
	<cfset variables.fMB1 = NULL>
	<cfset variables.fMB2 = NULL>

	<!--------------------------------------------------------------->

	<cffunction name="setUp" returntype="void" access="private" output="false" hint="">
		<cfset variables.f12CHF = newObject("org.cfcunit.samples.money.Money").init(12, "CHF")>
		<cfset variables.f14CHF = newObject("org.cfcunit.samples.money.Money").init(14, "CHF")>
		<cfset variables.f7USD = newObject("org.cfcunit.samples.money.Money").init(7, "USD")>
		<cfset variables.f21USD = newObject("org.cfcunit.samples.money.Money").init(21, "USD")>
		<cfset variables.fMB1 = variables.MoneyBag.create(variables.f12CHF, variables.f7USD)>
		<cfset variables.fMB2 = variables.MoneyBag.create(variables.f14CHF, variables.f21USD)>
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testBagMultiply" returntype="void" access="public" output="false" hint="">
		// {[12 CHF][7 USD]} *2 == {[24 CHF][14 USD]}
		IMoney expected= MoneyBag.create(new Money(24, "CHF"), new Money(14, "USD"));
		assertEquals(expected, fMB1.multiply(2)); 
		assertEquals(fMB1, fMB1.multiply(1));
		assertTrue(fMB1.multiply(0).isZero());
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testBagNegate" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testBagSimpleAdd" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testBagSubtract" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testBagSumAdd" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testIsZero" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testMixedSimpleAdd" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testBagNotEquals" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testMoneyBagEquals" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testMoneyBagHash" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testMoneyEquals" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="testMoneyHash" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testSimplify" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testNormalize2" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="testNormalize3" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testNormalize4" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="testPrint" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testSimpleAdd" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testSimpleBagAdd" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="testSimpleMultiply" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testSimpleNegate" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->

	<cffunction name="testSimpleSubtract" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!--------------------------------------------------------------->
	<!--------------------------------------------------------------->
	
	<cffunction name="newMoney" returntype="org.cfcunit.samples.money.Money" access="private" output="false" hint="">
		<cfset var money = NULL>
		
		<cfreturn money/>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>