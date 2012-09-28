<cfcomponent>

	<cffunction name="init" access="public" hint="I configure and return a fortune CFC" output="false" returntype="Fortune">
		<cfargument name="datasource" hint="I am the coldfusion datasource to use" required="true" type="string" />
		<cfargument name="username" hint="I am the username to user" required="no" type="string" default="" />
		<cfargument name="password" hint="I am the password to use" required="no" type="string" default="" />
		
		<cfset variables.datasource = arguments.datasource />
		<cfset variables.username = arguments.username />
		<cfset variables.password = arguments.password />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getCategories" access="public" hint="I get a query of categories" output="false" returntype="query">
		<cfset var categories = 0 />
		
		<cfquery name="categories" datasource="#variables.datasource#" username="#variables.username#" password="#variables.password#">
			SELECT c.categoryId, c.category + ' (' + Convert(varchar, count(f.fortuneId)) + ')' as category
			FROM Category as c JOIN Fortune as f
				ON c.categoryId = f.categoryId
			GROUP BY c.categoryId, c.category
			ORDER BY c.category
		</cfquery>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getFortune" access="public" hint="I get a fortune and return it" output="false" returntype="string">
		<cfargument name="categoryId" hint="I am the id of the cateogry to get the fortune from" required="yes" type="numeric" />
		<cfset var fortune = 0 />
		
		<cfquery name="fortune" datasource="#variables.datasource#" username="#variables.username#" password="#variables.password#">
			SELECT TOP 1 fortune
			FROM Fortune
			WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryId#" />
			ORDER BY newId()
		</cfquery>
			
		<cfreturn fortune.fortune />
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