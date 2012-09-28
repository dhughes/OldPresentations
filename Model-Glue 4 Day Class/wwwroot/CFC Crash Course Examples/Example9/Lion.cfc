<cfcomponent extends="Cat"
	hint="A BIG cat.">
	
	<cffunction name="roar"
		hint="I make the lion roar."
		output="false"
		returntype="string">
		<cfargument name="volume"
			hint="I am the volume with which to roar."
			required="no"
			default="12"
			type="numeric" />
		<cfreturn "<p style=""font-size: #arguments.volume#"">ROAR!</p>" />
	</cffunction>
	
	<!--- override the describe method --->
	<cffunction name="describe"
		hint="I return a description of the loin."
		access="public"
		output="false"
		returntype="string">
		<cfreturn "#super.describe()#  I've got a big furry mane." />
	</cffunction>

	<!--- set weight --->
    <cffunction name="setWeight"
		access="private"
		output="false"
		returntype="void"
		hint="Sets the weight of the lion">
		<cfargument name="weight"
			hint="The weight of the lion in pounds.  No limit for lions."
			required="yes"
			type="numeric" />
		<!--- set the variables.weight value to arguments.weight --->
		<cfset variables.weight = arguments.weight />
    </cffunction>
	
</cfcomponent>