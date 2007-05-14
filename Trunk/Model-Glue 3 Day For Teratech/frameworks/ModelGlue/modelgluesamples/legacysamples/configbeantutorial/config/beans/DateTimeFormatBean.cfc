<cfcomponent output="false">

<cffunction name="Init" output="false">
  <cfset variables.timeFormat = "" />
  <cfset variables.dateFormat = structNew() />
  <cfset variables.dateFormat.short = "" />
  <cfset variables.dateFormat.long = "" />
  <cfreturn this />
</cffunction>

<cffunction name="SetTimeFormat" output="false">
  <cfargument name="value" type="string" required="true" />
  <cfset variables.timeFormat = arguments.value />
</cffunction>

<cffunction name="GetTimeFormat" output="false">
  <cfreturn variables.timeFormat />
</cffunction>

<cffunction name="SetDateFormat" output="false">
  <cfargument name="value" type="struct" required="true" />
  <cfset variables.dateFormat = arguments.value />
</cffunction>

<cffunction name="GetDateFormat" output="false">
  <cfreturn variables.dateFormat />
</cffunction>

</cfcomponent>
