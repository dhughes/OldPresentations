<cfcomponent>
	
	<cffunction name="init" access="public" hint="I configure and return the Cateogory Gateway" output="false" returntype="FortuneDao">
		<cfargument name="Datasource" hint="I am the datasource to use when reading data" required="yes" type="Datasource">
		
		<cfset variables.Datasource = arguments.Datasource />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="create" access="public" hint="I insert a new Fortune in the database" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to add" required="yes" type="FortuneBean" />
		<cfset var insert = 0 />
	
		<cfquery name="insert" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			INSERT INTO Fortune
			(
				categoryId,
				fortune
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FortuneBean.getCategoryId()#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.FortuneBean.getFortune()#" />
			)
			
			SELECT @@IDENTITY as fortuneId
		</cfquery>
		
		<!--- set the id into the fortune --->
		<cfset arguments.FortuneBean.setFortuneId(insert.fortuneID) />
	</cffunction>
	
	<cffunction name="readRandom" access="public" hint="I read a random fortune from the database based on a provided categoryId" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to read" required="yes" type="FortuneBean" />
		<cfset var read = 0 />
	
		<cfquery name="read" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT TOP 1 fortuneId, fortune
			FROM Fortune
			WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FortuneBean.getCategoryId()#" />
			ORDER BY newId()
		</cfquery>
		
		<cfif read.recordcount>
			<cfset arguments.FortuneBean.setFortuneId(read.fortuneId) />
			<cfset arguments.FortuneBean.setFortune(read.fortune) />
		<cfelse>
			<cfthrow message="FortuneId Not Found" detail="The fortuneId set in the provided Fortune Bean could did not exist" type="FortuneDao.read.NoSuchRecord" />
		</cfif>
	</cffunction>
	
	<cffunction name="read" access="public" hint="I read a fortune from the database" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to read" required="yes" type="FortuneBean" />
		<cfset var read = 0 />
	
		<cfquery name="read" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT categoryId, fortune
			FROM Fortune
			WHERE fortuneId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FortuneBean.getFortuneId()#" />
		</cfquery>
		
		<cfif read.recordcount>
			<cfset arguments.FortuneBean.setCategoryId(read.categoryId) />
			<cfset arguments.FortuneBean.setFortune(read.fortune) />
		<cfelse>
			<cfthrow message="FortuneId Not Found" detail="The fortuneId set in the provided Fortune Bean could did not exist" type="FortuneDao.read.NoSuchRecord" />
		</cfif>
	</cffunction>
	
	<cffunction name="update" access="public" hint="I update a fortune in the database" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to read" required="yes" type="FortuneBean" />
		<cfset var update = 0 />
	
		<cfquery name="update" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			UPDATE Fortune
			SET
				categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FortuneBean.getCategoryId()#" />,
				fortune = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.FortuneBean.getFortune()#" />
			WHERE fortuneId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FortuneBean.getFortuneId()#" />
		</cfquery>
	</cffunction>
	
	<cffunction name="delete" access="public" hint="I delete a fortune form the database" output="false" returntype="void">
		<cfargument name="FortuneBean" hint="I am the fortune bean to delete" required="yes" type="FortuneBean" />
		<cfset var update = 0 />
	
		<cfquery name="update" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			DELETE FROM Fortune
			WHERE fortuneId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.FortuneBean.getFortuneId()#" />
		</cfquery>
		
		<cfset arguments.FortuneBean = CreateObject("Component", "FortuneBean") />
	</cffunction>

</cfcomponent>