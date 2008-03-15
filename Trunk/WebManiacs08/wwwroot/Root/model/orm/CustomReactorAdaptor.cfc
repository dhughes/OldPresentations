<cfcomponent hint="I am a custom implementation of the MG:U ReactorAdaptor" extends="ModelGlue.unity.orm.ReactorAdapter">

	<cffunction name="delete" returntype="any" output="false" access="public">
		<cfargument name="table" type="string" required="true" />
		<cfargument name="primaryKeys" type="struct" required="true" />
		<cfset var record = read(arguments.table, arguments.primaryKeys) />
		<cfset record.setDeleted(1) />
		<cfset record.save(useTransaction=false) />
	</cffunction>
		
	<cffunction name="list" returntype="any" output="false" access="public">
		<cfargument name="table" type="string" required="true" />
		<cfargument name="criteria" type="struct" required="false" />
		<cfargument name="orderColumn" type="string" required="false" />
		<cfargument name="orderAscending" type="boolean" required="false" default="true" />
		<cfargument name="gatewayMethod" type="string" required="false" />
		<cfargument name="gatewayBean" type="string" required="false" />
		<cfset var fields = getReactor().createMetadata(arguments.table).getFieldQuery() />
		<cfset var gw = getReactor().createGateway(arguments.table) />
		<cfset var field = "" />
		<cfset var result = "" />
		<cfset var query = gw.createQuery() />
		<cfset var where = query.getWhere() />
		<cfset var order = query.getOrder() />
		
		<cfif ListFindNoCase(ValueList(fields.name), "deleted")>
			<cfset arguments.criteria.deleted = 0 />
		</cfif>
		
		<cfif not structKeyExists(arguments, "gatewayMethod")>
			<cfloop collection="#arguments.criteria#" item="field">
					<cfset where.isEqual(arguments.table, field, arguments.criteria[field]) />
			</cfloop>
			
			<cfif structKeyExists(arguments, "orderColumn")>
				<cfloop list="#arguments.orderColumn#" index="field">
					<cfif arguments.orderAscending>
						<cfset order.setAsc(arguments.table, field) />
					<cfelse>
						<cfset order.setDesc(arguments.table, field) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset result = gw.getByQuery(query) />
		<cfelse>
			<cfinvoke component="#gw#" method="#arguments.gatewaymethod#" argumentcollection="#criteria#" returnvariable="result" />
		</cfif>
		
		<cfreturn result />
	</cffunction>
	
</cfcomponent>