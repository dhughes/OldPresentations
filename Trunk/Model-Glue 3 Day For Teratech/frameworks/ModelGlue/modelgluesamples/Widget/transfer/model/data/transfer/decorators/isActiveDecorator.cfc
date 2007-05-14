<!-- isActiveDecorator:  Assumes a property named "isActive" exists -->
<cfcomponent extends="transfer.com.TransferDecorator">

<cffunction name="listActive">
	<cfset var criteria = structNew() />
	<cfset criteria.isActive = 1 />
	
	<cfreturn getTransfer().listByPropertyMap(this.getClassName(), criteria) />
</cffunction>

</cfcomponent>