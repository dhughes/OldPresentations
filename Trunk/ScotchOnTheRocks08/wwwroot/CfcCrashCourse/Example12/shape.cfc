<cfinterface>
	
	<cffunction name="getArea" access="public" returntype="numeric">			
	</cffunction>
	
	<cffunction name="getPerimeter" access="public" returntype="numeric">	
	</cffunction>	
	
	<cffunction name="setColor" access="public" output="false" returnType="void">
		<cfargument name="color" required="yes" type="string" />
	</cffunction>
	
	<cffunction name="getColor" access="public" output="false" returnType="string">
	</cffunction>

</cfinterface>