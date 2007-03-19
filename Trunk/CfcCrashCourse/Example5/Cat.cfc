<cfcomponent displayname="Cat"
	hint="A cat component.">

	<cfset variables.color = "" />
	<cfset variables.weight = "" />
	<cfset variables.name = "" />
	
	<!--- pseudo constructor --->
	<cffunction name="init"
		hint="I am the cat components pseudo constructor.  I configure the cat."
		output="false"
		returntype="Cat">
		<cfargument name="color"
			hint="The color of the cat."
			required="yes"
			type="string" />
		<cfargument name="name"
			hint="The name of the cat."
			required="yes"
			type="string" />
		<cfargument name="weight"
			hint="The weight of the cat in pounds.  Must be between 1 and 30 pounds."
			required="yes"
			type="numeric" />
		<!--- configure the cat --->
		<cfset setColor(arguments.color) />
		<cfset setName(arguments.name) />
		<cfset setWeight(arguments.weight) />
		<!--- return the configured cat --->
		<cfreturn this />
	</cffunction>
	
	<cffunction name="describe"
		hint="I return a description of the cat."
		access="public"
		output="false"
		returntype="string">
		<cfreturn "I am a #getColor()# cat weighing in at #getWeight()# pounds.  My name is #getName()#!" />
	</cffunction>
	
	<!--- set color --->
    <cffunction name="setColor"
		access="private"
		output="false"
		returntype="void"
		hint="Sets the color of the cat">
		<cfargument name="color"
			hint="The color of the cat."
			required="yes"
			type="string" />
		<!--- set the variables.color value to arguments.color --->
		<cfset variables.color = arguments.color />
    </cffunction>
	
	<!--- get color --->
    <cffunction
		name="getColor"
		access="public"
		output="false"
		returntype="string"
		hint="Gets the color of the cat">
		<!--- return the value of variables.color --->
		<cfreturn variables.color />
    </cffunction>
	
	<!--- set name --->
    <cffunction name="setName"
		access="private"
		output="false"
		returntype="void"
		hint="Gets the name of the cat">
		<cfargument name="name"
			hint="The name of the cat."
			required="yes"
			type="string" />
		<!--- set the variables.name value to arguments.name --->
		<cfset variables.name = arguments.name />
    </cffunction>
	
	<!--- get name --->
    <cffunction
		name="getName"
		access="public"
		output="false"
		returntype="string"
		hint="Sets the name of the cat">
		<!--- return the value of variables.name --->
		<cfreturn variables.name />
    </cffunction>
	
	<!--- set weight --->
    <cffunction name="setWeight"
		access="private"
		output="false"
		returntype="void"
		hint="Sets the weight of the cat">
		<cfargument name="weight"
			hint="The weight of the cat in pounds.  Must be between 1 and 30 pounds."
			required="yes"
			type="numeric" />
		<!--- verify the value of weight --->
		<cfif arguments.weight LT 1 OR arguments.weight GT 30>
			<cfthrow
				message="Invalid weight (#arguments.weight#).  A cat must weigh between 1 and 30 pounds." />
		</cfif>
		<!--- set the variables.weight value to arguments.weight --->
		<cfset variables.weight = arguments.weight />
    </cffunction>
	
	<!--- get weight --->
    <cffunction
		name="getWeight"
		access="public"
		output="false"
		returntype="string"
		hint="Gets the weight of the cat">
		<!--- return the value of variables.weight --->
		<cfreturn variables.weight />
    </cffunction>
</cfcomponent>