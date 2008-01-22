<cfcomponent output="false">

<cffunction name="Init" output="false">
  <cfset variables.timeFormat = "" />
  <cfreturn this />
</cffunction>

<cffunction name="SetTimeFormat" output="false">
  <cfargument name="value" type="string" required="true" />
  <cfset variables.timeFormat = arguments.value />
</cffunction>

<cffunction name="GetTimeFormat" output="false">
  <cfreturn variables.timeFormat />
</cffunction>

</cfcomponent>
