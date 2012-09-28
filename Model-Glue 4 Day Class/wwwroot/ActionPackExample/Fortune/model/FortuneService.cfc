<cfcomponent>

	<cffunction name="init" access="public" hint="I configure and return a fortune CFC" output="false" returntype="FortuneService">
		<cfargument name="CategoryGateway" hint="I am the CategoryGateway" required="yes" type="ActionPackExample.Fortune.model.CategoryGateway" />
		<cfargument name="FortuneDao" hint="I am the FortuneDao" required="yes" type="ActionPackExample.Fortune.model.FortuneDao" />
		
		<cfset variables.CategoryGateway = arguments.CategoryGateway />
		<cfset variables.FortuneDao = arguments.FortuneDao />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getCategories" access="public" hint="I get a query of categories" output="false" returntype="query">
		<cfreturn variables.CategoryGateway.getCategories() />
	</cffunction>
	
	<cffunction name="getFortune" access="public" hint="I get a fortune and return it" output="false" returntype="string">
		<cfargument name="categoryId" hint="I am the id of the cateogry to get the fortune from" required="yes" type="numeric" />
		<cfset var FortuneBean = CreateObject("Component", "ActionPackExample.Fortune.model.FortuneBean") />
		
		<cfset FortuneBean.setCategoryId(arguments.categoryId) />
		
		<cfset variables.FortuneDao.readRandom(FortuneBean) />
					
		<cfreturn FortuneBean.getFortune() />
	</cffunction>
	
	<cffunction name="logFortune" access="public" hint="I log fortunes" output="false" returntype="void">
		<cfargument name="fortune" hint="I am the fortune to log" required="yes" type="string" />
		<cfparam name="session.fortuneLog" default="#ArrayNew(1)#" />
		
		<cfset ArrayAppend(session.fortuneLog, arguments.fortune) />		
	</cffunction>
	
	<cffunction name="getRecentFortunes" access="public" hint="I return the last X number of fortunes" output="false" returntype="Array">
		<cfargument name="max" hint="I am the max number of fortunes to return" required="yes" type="numeric" />
		<cfset var result = ArrayNew(1) />
		<cfset var x = 0 />
		<cfparam name="session.fortuneLog" default="#ArrayNew(1)#" />
		
		<cfloop from="#ArrayLen(session.fortuneLog)#" to="#ArrayLen(session.fortuneLog) - 10#" index="x" step="-1">
			<cfif x IS 0 OR ArrayLen(result) IS arguments.max>
				<cfbreak />
			</cfif>
			
			<cfset ArrayAppend(result, session.fortuneLog[x]) />
		</cfloop>
		
		<cfreturn result />		
	</cffunction>

</cfcomponent>