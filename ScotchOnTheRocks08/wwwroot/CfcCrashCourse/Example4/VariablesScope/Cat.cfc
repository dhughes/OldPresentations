<cfcomponent hint="A cat component.">

	<cfset variables.color = "" />
	<cfset variables.weight = "" />
	<cfset variables.name = "" />
	
	<cffunction name="describe"
		access="public"
		hint="I return a description of the cat."
		output="false"
		returntype="string">
		<cfreturn "I am a #variables.color# cat weighing in at #variables.weight#.  My name is #variables.name#!" />
	</cffunction>
</cfcomponent>