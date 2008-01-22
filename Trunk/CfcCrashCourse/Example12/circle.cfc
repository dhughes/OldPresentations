<cfcomponent implements="shape">

	<cfset variables.radius = 0 />
	<cfset variables.color = "" />

	<cffunction name="getRadius" access="public" hint="Getter for radius" output="false" returnType="numeric">
		<cfreturn variables.radius />
	</cffunction>

	<cffunction name="setRadius" access="public" hint="Setter for radius" output="false" returnType="void">
		<cfargument name="radius" hint="I am the radius of the circle in inches." required="yes" type="numeric" />
		<cfset variables.radius = arguments.radius />
	</cffunction>

	<cffunction name="getArea" access="public" returntype="numeric">
		<cfreturn 3.14 * (getRadius() * getRadius()) />
	</cffunction>
	
	<cffunction name="getPerimeter" access="public" returntype="numeric">
		<cfreturn 2 * 3.14 * getRadius() />	
	</cffunction>

	<cffunction name="getColor" access="public" hint="Getter for color" output="false" returnType="string">
		<cfreturn variables.color />
	</cffunction>

	<cffunction name="setColor" access="public" hint="Setter for color" output="false" returnType="void">
		<cfargument name="color" hint="I am the shape's color" required="yes" type="string" />
		<cfset variables.color = arguments.color />
	</cffunction>
</cfcomponent>