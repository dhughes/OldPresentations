<cfcomponent>
	
	<cfset variables.fortuneId = 0 />
	<cfset variables.categoryId = 0 />
	<cfset variables.fortune = "" />
	
	<!--- fortuneId --->
    <cffunction name="setFortuneId" access="public" output="false" returntype="void">
       <cfargument name="fortuneId" hint="I return the fortuneId" required="yes" type="numeric" />
       <cfset variables.fortuneId = arguments.fortuneId />
    </cffunction>
    <cffunction name="getFortuneId" access="public" output="false" returntype="numeric">
       <cfreturn variables.fortuneId />
    </cffunction>
	
	<!--- categoryId --->
    <cffunction name="setCategoryId" access="public" output="false" returntype="void">
       <cfargument name="categoryId" hint="I return the categoryId" required="yes" type="numeric" />
       <cfset variables.categoryId = arguments.categoryId />
    </cffunction>
    <cffunction name="getCategoryId" access="public" output="false" returntype="numeric">
       <cfreturn variables.categoryId />
    </cffunction>
	
	<!--- fortune --->
    <cffunction name="setFortune" access="public" output="false" returntype="void">
       <cfargument name="fortune" hint="I return the fortune" required="yes" type="string" />
       <cfset variables.fortune = arguments.fortune />
    </cffunction>
    <cffunction name="getFortune" access="public" output="false" returntype="string">
       <cfreturn variables.fortune />
    </cffunction>
	
</cfcomponent>