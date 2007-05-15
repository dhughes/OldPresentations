<cfcomponent extends="org.cfcunit.framework.TestCase" output="false" >

	<cffunction name="setup" returntype="void" access="private"> 
		<cfsetting showdebugoutput="false" />
		<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
		<cfset ColdSpring.loadBeans("/Fortune - ColdSpring/config/ColdSpring.xml") />
		
		<cfset FortuneDao = ColdSpring.getBean("FortuneDao") />
		<cfset FortuneBean = CreateObject("component", "Fortune - ColdSpring.model.FortuneBean") />
	</cffunction>
	
	<!--- test Read Random Fortune --->
	<cffunction name="testReadRandom" returntype="void" access="public"> 
		<cfset FortuneBean.setCategoryId(1)>
		
		<!--- read a random fortune --->
		<cfset FortuneDao.readRandom(FortuneBean) />
		
		<!--- make sure the resulting fortune and category are the same as were written --->
		<cfset assertTrue(FortuneBean.getFortuneId() GT 0, "FortuneId shouldn't be less than 1") />
		<cfset assertEqualsNumber(FortuneBean.getCategoryId(), 1, "Fortune category is incorrect") />
		<cfset assertTrue(Len(FortuneBean.getFortune()) GT 0, "Fortune value is was not set") />
	</cffunction>		
	
	<!--- test Fortune Crud --->
	<cffunction name="testCRUD" returntype="void" access="public"> 
		<cfset var fortuneId = 0 />
		<cfset FortuneBean.setCategoryId(1)>
		<cfset FortuneBean.setFortune("Test")>
		
		<!--- assert that the fortune bean has 0 as a fortuneId --->
		<cfset assertEqualsNumber(FortuneBean.getFortuneId(), 0, "Fortune already has an id!") />
		
		<cfset FortuneDao.create(FortuneBean) />
		
		<!--- assert that the fortune has an id now --->
		<cfset fortuneId = FortuneBean.getFortuneId() />
		<cfset assertTrue(fortuneId GT 0, "Fortune not assigned an id!") />
		
		<!--- create a new fortune bean --->
		<cfset FortuneBean = CreateObject("Component", "Fortune - ColdSpring.model.FortuneBean") />
		<cfset FortuneBean.setFortuneId(fortuneId) />
		
		<!--- read the fortune to insure it was created --->
		<cfset FortuneDao.read(FortuneBean) />
		
		<!--- make sure the resulting fortune and category are the same as were written --->
		<cfset assertEqualsNumber(FortuneBean.getCategoryId(), 1, "Fortune category is incorrect!") />
		<cfset assertEqualsString(FortuneBean.getFortune(), "Test", "Fortune value is incorrect!") />
		
		<!--- update the fortune --->
		<cfset FortuneBean.setCategoryId(2)>
		<cfset FortuneBean.setFortune("Test 2")>
		
		<!--- update the fortune --->
		<cfset FortuneDao.update(FortuneBean) />
		
		<!--- create a new fortune bean --->
		<cfset FortuneBean = CreateObject("Component", "Fortune - ColdSpring.model.FortuneBean") />
		<cfset FortuneBean.setFortuneId(fortuneId) />
		
		<!--- read the fortune to insure it was created --->
		<cfset FortuneDao.read(FortuneBean) />
		
		<!--- make sure the resulting fortune and category are the same as were written --->
		<cfset assertEqualsNumber(FortuneBean.getCategoryId(), 2, "Fortune category is incorrect!") />
		<cfset assertEqualsString(FortuneBean.getFortune(), "Test 2", "Fortune value is incorrect!") />
		
		<!--- delete the fortune --->
		<cfset FortuneDao.delete(FortuneBean) />
		
		<!--- create a new fortune bean --->
		<cfset FortuneBean = CreateObject("Component", "Fortune - ColdSpring.model.FortuneBean") />
		<cfset FortuneBean.setFortuneId(fortuneId) />
		
		<!--- try to read the fortune to insure it was created --->
		<cftry>
			<cfset FortuneDao.read(FortuneBean) />
			<cfset fail("No error thrown when record does not exist")>
			<cfcatch type="FortuneDao.read.NoSuchRecord">
				<!--- correct error was thrown --->
			</cfcatch>
			<cfcatch>
				<cfset fail("Incorrect error thrown from FortuneDao: #cfcatch.type#") />
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>