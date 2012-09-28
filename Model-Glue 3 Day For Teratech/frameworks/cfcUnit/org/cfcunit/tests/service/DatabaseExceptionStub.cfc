<cfcomponent name="DatabaseExceptionStub" extends="ExceptionStub" output="false">
	
	<!------------------------------------------------------------------------------------>


	<cfproperty name="datasource" type="string"/>
	<cfproperty name="nativeErrorCode" type="string"/>
	<cfproperty name="sqlState" type="string"/>
	<cfproperty name="sql" type="string"/>
	<cfproperty name="where" type="string"/>

	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="init" returntype="DatabaseExceptionStub" access="public" output="false">
		<cfargument name="className" type="any" required="true"/>
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="detail" type="string" required="true"/>
		<cfargument name="datasource" type="string" required="false"/>
		<cfargument name="nativeErrorCode" type="string" require="true"/>
		<cfargument name="sqlState" type="string" required="true"/>
		<cfargument name="sql" type="string" required="false"/>
		<cfargument name="where" type="string" required="false"/>
		
		<cfset super.init(arguments.className, arguments.message, arguments.detail, "Database")>

		<cfif structKeyExists(arguments, "datasource")>
			<cfset this.Datasource = arguments.datasource>
		</cfif>
		
		<cfset this.nativeErrorCode = arguments.nativeErrorCode>
		
		<cfset this.sqlState = arguments.sqlState>
		
		<cfif structKeyExists(arguments, "sql")>
			<cfset this.sql = arguments.sql>
		</cfif>
		
		<cfif structKeyExists(arguments, "where")>
			<cfset this.where = arguments.where>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
</cfcomponent>