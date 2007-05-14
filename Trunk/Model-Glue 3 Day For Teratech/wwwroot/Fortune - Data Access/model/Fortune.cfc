<cfcomponent>

	<cffunction name="init" access="public" hint="I configure and return a fortune CFC" output="false" returntype="Fortune">
		<cfargument name="datasource" hint="I am the coldfusion datasource to use" required="true" type="string" />
		<cfargument name="username" hint="I am the username to user" required="no" type="string" default="" />
		<cfargument name="password" hint="I am the password to use" required="no" type="string" default="" />
		
		<cfset variables.Datasource = CreateObject("Component", "Fortune - Data Access.model.Datasource").init(arguments.datasource, arguments.username, arguments.password) />
		<cfset variables.CategoryGateway = CreateObject("Component", "Fortune - Data Access.model.CategoryGateway").init(variables.Datasource) />
		<cfset variables.FortuneDao = CreateObject("Component", "Fortune - Data Access.model.FortuneDao").init(variables.Datasource) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getCategories" access="public" hint="I get a query of categories" output="false" returntype="query">
		<cfreturn variables.CategoryGateway.getCategories() />
	</cffunction>
	
	<cffunction name="getFortune" access="public" hint="I get a fortune and return it" output="false" returntype="string">
		<cfargument name="categoryId" hint="I am the id of the cateogry to get the fortune from" required="yes" type="numeric" />
		<cfset var FortuneBean = CreateObject("Component", "Fortune - Data Access.model.FortuneBean") />
		
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