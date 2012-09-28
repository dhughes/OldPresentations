<cfif thistag.ExecutionMode IS "start">
	
	<cfswitch expression="#attributes.do#">
		<cfcase value="getCategories">
			<cfmodule template="categories.cfm" result="categories" />
			
			<cfset caller[attributes.result] = categories /> 
		</cfcase>
		<cfcase value="getFortune">
			<cfmodule template="fortune.cfm" result="fortune" categoryId="#form.categoryId#" />
			
			<cfset caller[attributes.result] = fortune />
		</cfcase>
	</cfswitch>


</cfif>