<cfcomponent extends="org.cfcunit.framework.TestCase" output="false" >

	<!--- setup the test --->
	<cffunction name="setup" returntype="void" access="private"> 
		<cfsetting showdebugoutput="false" />
		<cfset FortuneBean = CreateObject("Component", "Fortune - Data Access.model.FortuneBean") />
	</cffunction>
	
	<!--- test fortuneId --->
	<cffunction name="testGetSetFortuneId" returntype="void" access="public"> 
		<!--- test the default value --->
		<cfset assertEqualsNumber(FortuneBean.getFortuneId(), 0, "FortuneId is not defaulted to 0")>
		
		<!--- set the fortune id --->
		<cfset FortuneBean.setFortuneId(123) />
		
		<!--- test the new value --->
		<cfset assertEqualsNumber(FortuneBean.getFortuneId(), 123, "FortuneId is not being set or retrieved correctly")>
	</cffunction>
	
	<!--- test categoryId --->
	<cffunction name="testGetSetCategoryId" returntype="void" access="public"> 
		<!--- test the default value --->
		<cfset assertEqualsNumber(FortuneBean.getCategoryId(), 0, "CategoryId is not defaulted to 0")>
		
		<!--- set the category id --->
		<cfset FortuneBean.setCategoryId(123) />
		
		<!--- test the new value --->
		<cfset assertEqualsNumber(FortuneBean.getCategoryId(), 123, "CategoryId is not being set or retrieved correctly")>
	</cffunction>
	
	<!--- test fortune --->
	<cffunction name="testGetSetFortune" returntype="void" access="public"> 
		<!--- test the default value --->
		<cfset assertEqualsString(FortuneBean.getFortune(), "", "Fortune is not defaulted to empty string")>
		
		<!--- set the fortune --->
		<cfset FortuneBean.setFortune("test") />
		
		<!--- test the new value --->
		<cfset assertEqualsString(FortuneBean.getFortune(), "test", "Fortune is not being set or retrieved correctly")>
	</cffunction>
	
</cfcomponent>