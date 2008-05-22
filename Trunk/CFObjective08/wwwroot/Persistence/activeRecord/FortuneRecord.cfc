<cfcomponent>
	
	<cfset variables.fortuneId = 0 />
	<cfset variables.categoryId = 0 />
	<cfset variables.fortune = "" />
	
	<cffunction name="init" access="public" hint="I configure and return the Fortune Gateway" output="false" returntype="FortuneRecord">
		<cfargument name="Datasource" hint="I am the datasource to use when reading data" required="yes" type="Datasource">
		
		<cfset variables.Datasource = arguments.Datasource />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="save" access="public" hint="I save this fortune" output="false" returntype="void">
		<!--- does this have an id?  if so, update, otherwise, create --->
		<cfif getFortuneId()>
			<cfset update() />
		<cfelse>
			<cfset create() />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" hint="I insert a new Fortune in the database" output="false" returntype="void">
		<cfset var insert = 0 />
	
		<cfquery name="insert" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			INSERT INTO Fortune
			(
				categoryId,
				fortune
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getFortune()#" />
			)
			
			SELECT @@IDENTITY as fortuneId
		</cfquery>
		
		<!--- set the id into the fortune --->
		<cfset setFortuneId(insert.fortuneID) />
	</cffunction>
	
	<cffunction name="update" access="private" hint="I update a fortune in the database" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to read" required="yes" type="FortuneBean" />
		<cfset var update = 0 />
	
		<cfquery name="update" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			UPDATE Fortune
			SET
				categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />,
				fortune = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFortune()#" />
			WHERE fortuneId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getFortuneId()#" />
		</cfquery>
	</cffunction>
	
	<cffunction name="readRandom" access="public" hint="I load a random fortune from the database based on the current categoryId" output="false" returntype="void">
		<cfset var read = 0 />
	
		<cfquery name="read" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT TOP 1 fortuneId, fortune
			FROM Fortune
			WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />
			ORDER BY newId()
		</cfquery>
		
		<cfif read.recordcount>
			<cfset setFortuneId(read.fortuneId) />
			<cfset setFortune(read.fortune) />
		<cfelse>
			<cfthrow message="FortuneId Not Found" detail="The fortuneId set in the provided Fortune Bean could did not exist" type="FortuneDao.read.NoSuchRecord" />
		</cfif>
	</cffunction>
	
	<cffunction name="read" access="public" hint="I read a fortune from the database" output="false" returntype="void">
		<cfset var read = 0 />
	
		<cfquery name="read" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT categoryId, fortune
			FROM Fortune
			WHERE 
				<cfif getFortuneId()>
					fortuneId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getFortuneId()#" />
				<cfelse>
					categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />
			ORDER BY newId()
				</cfif>
		</cfquery>
		
		<cfif read.recordcount>
			<cfset setCategoryId(read.categoryId) />
			<cfset setFortune(read.fortune) />
		<cfelse>
			<cfthrow message="FortuneId Not Found" detail="The fortuneId set in the provided Fortune Bean could did not exist" type="FortuneDao.read.NoSuchRecord" />
		</cfif>
	</cffunction>
	
	<cffunction name="delete" access="public" hint="I delete a fortune form the database" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to delete" required="yes" type="FortuneBean" />
		<cfset var update = 0 />
	
		<cfquery name="update" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			DELETE FROM Fortune
			WHERE fortuneId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getFortuneId()#" />
		</cfquery>
		
		<cfset setFortuneId(0) />
		<cfset setCategoryId(0) />
		<cfset setFortune("") />
	</cffunction>
	
	<!--- fortuneId --->
    <cffunction name="setFortuneId" access="public" output="false" returntype="void">
       <cfargument name="fortuneId" hint="I return the fortuneId" required="yes" type="numeric" />
       <cfset variables.fortuneId = arguments.fortuneId />
    </cffunction>
    <cffunction name="getFortuneId" access="public" output="false" returntype="numeric">
       <cfreturn variables.fortuneId />
    </cffunction>
	
	<!--- categoryId --->
    <cffunction name="setCategoryId" access="public" output="false" returntype="void">
       <cfargument name="categoryId" hint="I return the categoryId" required="yes" type="numeric" />
       <cfset variables.categoryId = arguments.categoryId />
    </cffunction>
    <cffunction name="getCategoryId" access="public" output="false" returntype="numeric">
       <cfreturn variables.categoryId />
    </cffunction>
	
	<!--- fortune --->
    <cffunction name="setFortune" access="public" output="false" returntype="void">
       <cfargument name="fortune" hint="I return the fortune" required="yes" type="string" />
       <cfset variables.fortune = arguments.fortune />
    </cffunction>
    <cffunction name="getFortune" access="public" output="false" returntype="string">
       <cfreturn variables.fortune />
    </cffunction>
	
</cfcomponent>