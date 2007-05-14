<cfcomponent>

	<cffunction name="init" access="public" hint="I configure and return the FortuneService" output="false" returntype="FortuneService">
		<cfargument name="CategoryGateway" hint="I am the gateway used to get category data" required="yes" type="Fortune.model.data.gateway.CategoryGateway">
		<cfargument name="FortuneGateway" hint="I am the gateway used to get random fortunes" required="yes" type="Fortune.model.data.gateway.FortuneGateway">
		
		<cfset variables.CategoryGateway = arguments.CategoryGateway />
		<cfset variables.FortuneGateway = arguments.FortuneGateway />
		
		<cfreturn this />
	</cffunction> 

	<cffunction name="getCategories" access="public" hint="I return a query of categories" output="false" returntype="query">
		<cfreturn variables.CategoryGateway.getCategories() />
	</cffunction>

	<cffunction name="getFortune" access="public" hint="I return a random fortune in a category" output="false" returntype="string">
		<cfargument name="categoryId" hint="I am the id of the cateogry to get the fortune from" required="yes" type="numeric" />
		<cfreturn variables.FortuneGateway.getRandomFortune(arguments.categoryId) />
 	</cffunction>
	
</cfcomponent>