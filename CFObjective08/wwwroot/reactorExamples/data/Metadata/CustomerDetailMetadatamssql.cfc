
<cfcomponent hint="I am the mssql custom Metadata object for the CustomerDetail object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="CustomerDetailMetadata">
	<!--- Place custom code here, it will not be overwritten --->

	<cfset variables.metadata.owner = "dbo" />
	<cfset variables.metadata.dbms = "mssql" />
	
</cfcomponent>
	
