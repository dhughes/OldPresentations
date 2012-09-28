<cfcomponent implements="shape">

	<cfset variables.width = 0 />
	<cfset variables.height = 0 />

	<cffunction name="getWidth" access="public" hint="Getter for width" output="false" returnType="numeric">
		<cfreturn variables.width />
	</cffunction>

	<cffunction name="setWidth" access="public" hint="Setter for width" output="false" returnType="void">
		<cfargument name="width" hint="I am the width of the rectangle" required="yes" type="numeric" />
		<cfset variables.width = arguments.width />
	</cffunction>

	<cffunction name="getHeight" access="public" hint="Getter for height" output="false" returnType="numeric">
		<cfreturn variables.height />
	</cffunction>

	<cffunction name="setHeight" access="public" hint="Setter for height" output="false" returnType="void">
		<cfargument name="height" hint="I am the height of the rectangle." required="yes" type="numeric" />
		<cfset variables.height = arguments.height />
	</cffunction>
	
	<cffunction name="getArea" access="public" returntype="numeric">
		<cfreturn getWidth() * getHeight() />			
	</cffunction>
	
	<cffunction name="getPerimeter" access="public" returntype="numeric">
		<cfreturn getWidth() * 2 + getHeight() * 2 />
	</cffunction>


</cfcomponent>