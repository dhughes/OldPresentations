<cfcomponent hint="A cat component.">

	<cfset this.color = "" />
	<cfset this.weight = "" />
	<cfset this.name = "" />
	
	<cffunction name="describe"
		access="public"
		hint="I return a description of the cat."
		output="false"
		returntype="string">
		<cfreturn "I am a #this.color# cat weighing in at #this.weight#.  My name is #this.name#!" />
	</cffunction>
	
</cfcomponent>