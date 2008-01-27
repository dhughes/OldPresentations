<cfset CustomerRecord = viewstate.getValue("CustomerRecord") />
<cfset CustomerValidation = viewstate.getValue("CustomerValidation") />

<h1><cfif CustomerRecord.getCustomerId()>Edit<cfelse>Add</cfif> Customer:</h1>

<cfif IsStruct(CustomerValidation)>
	<cfdump var="#CustomerValidation#" />
</cfif>

<cfform action="index.cfm?event=SaveCustomer">
	<cfinput type="hidden" name="customerId" value="#CustomerRecord.getCustomerId()#"  />
	
	<p>
		<strong>First Name:</strong>
		<cfinput type="text" name="firstName" value="#CustomerRecord.getFirstName()#" />
	</p>
	
	<p>
		<strong>Last Name:</strong>
		<cfinput type="text" name="lastName" value="#CustomerRecord.getLastName()#" />
	</p>

	<cfinput type="Submit" name="submit" />

</cfform>