<cfset CustomerQuery = viewstate.getValue("CustomerQuery") />

<h1>Customers:</h1>

<p>
	<a href="index.cfm?event=CustomerForm">Add a Customer</a>
</p>

<table border="1" cellpadding="5">
	<tr>
		<td>First Name</td>
		<td>Last Name</td>
		<td>&nbsp;</td>
	</tr>
	<cfoutput query="CustomerQuery">
		<tr>
			<td>#CustomerQuery.firstName#</td>
			<td>#CustomerQuery.lastName#</td>
			<td>
				<a href="index.cfm?event=CustomerForm&customerID=#CustomerQuery.customerId#">Edit</a> |
				<a href="index.cfm?event=DeleteCustomer&customerID=#CustomerQuery.customerId#">Delete</a>
			</td>
		</tr>
	</cfoutput>
</table>