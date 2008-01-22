<cfcomponent name="" hint="">

	<cfset variables.shapes = arrayNew(1) />

	<cffunction name="addShape" access="public" hint="I add a shape to this collection" output="false" returnType="void">
		<cfargument name="shape" hint="I am a collection of shapes" required="yes" type="Shape" />
		<cfset ArrayAppend(variables.shapes, arguments.shape) />
	</cffunction>
	
	<cffunction name="getTotalArea" access="public" returntype="numeric">
		<cfset var x = 0 />
		<cfset var total = 0 />
		
		<cfloop from="1" to="#ArrayLen(variables.shapes)#" index="x">
			<cfset total += variables.shapes[x].getArea() />
		</cfloop>	
		
		<cfreturn total />				
	</cffunction>
	
	<cffunction name="getTotalPerimeter" access="public" returntype="numeric">
		<cfset var x = 0 />
		<cfset var total = 0 />
		
		<cfloop from="1" to="#ArrayLen(variables.shapes)#" index="x">
			<cfset total += variables.shapes[x].getPerimeter() />
		</cfloop>		
		
		<cfreturn total />				
	</cffunction>


</cfcomponent>