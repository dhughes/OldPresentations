
<cfcomponent hint="I am the database agnostic custom Gateway object for the Fortune object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.ReactorFortune.Gateway.FortuneGateway" >
	<!--- Place custom code here, it will not be overwritten --->
		
	<cffunction name="getRandomFortune" access="public" hint="I return a random of fortune in the specified category" output="false" returntype="string">
		<cfargument name="categoryId" hint="I am the categoryId" required="yes" type="numeric" />
		<cfset var fortune = 0 />
		
		<cfquery name="fortune" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT TOP 1 fortune
			FROM Fortune
			WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryId#" />
			ORDER BY newId()
		</cfquery>
		
		<cfif fortune.recordcount>
			<cfreturn fortune.fortune />
		<cfelse>
			<cfthrow message="FortuneId Not Found" detail="The fortuneId set in the provided Fortune Bean could did not exist" type="FortuneDao.read.NoSuchRecord" />
		</cfif>
		
	</cffunction>
	
	
</cfcomponent>
	
